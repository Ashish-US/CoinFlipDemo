//
//  CoinFlipViewController.swift
//  CoinFlipDemoApp
//
//  Created by Ashish Singh on 2/25/23.
//

import UIKit
import Combine

class CoinFlipViewController: UIViewController {

    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 100.0
        tableview.backgroundColor = .black
        return tableview
    }()

    private var viewModel: ViewModelActionable
    private lazy var dataModelArray = [CoinFlipDataModel]()
    private var subscription = Set<AnyCancellable>()
    
    init(viewModel: CoinFlipViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        tableView.delegate = self
        tableView.dataSource = self
        
        // bind output from view model
        bindOutput()
        
        viewModel.handleEvent(input: .fetchData)
    }
    
    func setUpView() {
        self.title = "CoinFlipList"
        view.addSubview(tableView)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemGray
        setUpConstraints()
    }
    
    func setUpConstraints() {
        [tableView.topAnchor.constraint(equalTo: view.topAnchor),
         tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)].forEach {
            $0.isActive = true
        }
    }
    
    func bindOutput() {
        viewModel.subject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(_) = completion {
                    self?.showError()
                }
            } receiveValue: { [weak self] result in
                self?.dataModelArray = result
                self?.tableView.reloadData()
            }
            .store(in: &self.subscription)

    }
    
    private func showError() {
        let alert = UIAlertController(title: "ERROR", message: "Unable to fetch data. Try Later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}

extension CoinFlipViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.contentView.backgroundColor = .black

        // title
        let data = dataModelArray[indexPath.row]
        cell.titleLabel.text = data.name
        
        // avoid reusable cell to show old image
        cell.thumbNail.image = nil

        // get and set thumbnail
        if let url = data.image?.thumb {
            cell.thumbNail.downloadImageFrom(url: url){ (res) in
                cell.thumbNail.image = res
            }
        }

        // price
        let double = data.market_data?.current_price?.usd
        cell.priceLabel.text =  "$\(double?.description ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.handleEvent(input: .userSelection(row: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
