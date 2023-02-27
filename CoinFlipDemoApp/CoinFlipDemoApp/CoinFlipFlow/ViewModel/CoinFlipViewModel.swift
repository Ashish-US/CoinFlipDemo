//
//  CoinFlipViewModel.swift
//  CoinFlipDemoApp
//
//  Created by Ashish Singh on 2/25/23.
//

import Foundation
import Combine

enum Input {
    case fetchData
    case userSelection(row: Int)
}

protocol ViewModelActionable {
    var subject: PassthroughSubject<[CoinFlipDataModel], AppErrors> {get}
    func handleEvent(input: Input)
}

class CoinFlipViewModel {
    private let flowController: FlowControllable
    private let networkManager: NetworkHandler
    var subject = PassthroughSubject<[CoinFlipDataModel], AppErrors>()

    // Dependency Injection
    init(flowController: FlowControllable, networkManager: NetworkHandler) {
        self.flowController = flowController
        self.networkManager = networkManager
    }
}

extension CoinFlipViewModel: ViewModelActionable {
    func handleEvent(input: Input) {
        switch input {
        case .fetchData:
            networkManager.fetchData { [weak self] result in
                switch result {
                case .success(let data):
                    self?.subject.send(data)
                case .failure(let error):
                    self?.subject.send(completion: .failure(error))
                }
            }
        case .userSelection:
            flowController.handleNavigation(destination: .detailScreen)
        }
    }
    
}
