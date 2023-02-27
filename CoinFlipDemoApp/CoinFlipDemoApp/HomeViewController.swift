//
//  HomeViewController.swift
//  CoinFlipDemoApp
//
//  Created by Ashish Singh on 2/25/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    func setUpView() {
        view.backgroundColor = .systemOrange
        view.addSubview(stackView)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false

        self.title = "Dashboard"
        let button1 = UIButton.create(with: "CoinList", style: .large())
        button1.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        let button2 = UIButton.create(with: "More Flow", style: .large())
        
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        
        setUpContraint()
    }
    
    @objc func buttonClicked() {
        let networkManager = NetworkManager()
        let flowController = FlowController(navController: navigationController,
                                            networkManager: networkManager)
        flowController.handleNavigation(destination: .coinFlipListScreen)
    }
    
    func setUpContraint() {
        [stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
            .forEach {  $0.isActive = true }
    }
}
