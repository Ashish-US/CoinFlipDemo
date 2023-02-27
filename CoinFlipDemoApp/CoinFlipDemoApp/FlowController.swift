//
//  FlowController.swift
//  CoinFlipDemoApp
//
//  Created by Ashish Singh on 2/26/23.
//

import UIKit

enum Destination {
    case coinFlipListScreen
    case detailScreen
}

protocol FlowControllable {
    func handleNavigation(destination: Destination)
}

//******************************************************************************
// FlowController will control the business flow
// Screen should not know about business flow
//******************************************************************************

class FlowController: FlowControllable {
    private let navController: UINavigationController?
    private let networkManager: NetworkHandler

    init(navController: UINavigationController?,
         networkManager: NetworkHandler) {
        self.navController = navController
        self.networkManager = networkManager
    }

    // handle navigation to show next screen
    func handleNavigation(destination: Destination) {
        switch destination {
        case .coinFlipListScreen:
            let viewModel = CoinFlipViewModel(
                flowController: self,
                networkManager: networkManager)
            let vc = CoinFlipViewController(viewModel: viewModel)
            navController?.pushViewController(vc, animated: true)

        case .detailScreen:
            print("to be implemented")
        }
    }
    
    func goBack() {
        _ = navController?.popViewController(animated: true)
    }
}
