//
//  MockNetworkManager.swift
//  CoinFlipDemoAppTests
//
//  Created by Ashish Singh on 2/26/23.
//

import Foundation
@testable import CoinFlipDemoApp

class MockNetworkManager: NetworkHandler {
    var mockResult: Result<[CoinFlipDataModel], AppErrors>?
    var isFetchDataCalled = false
    
    func fetchData(completion: @escaping (Result<[CoinFlipDataModel], AppErrors>) -> Void) {
        isFetchDataCalled = true
        if let mockResult = mockResult {
            completion(mockResult)
        }
    }
}

extension CoinFlipDataModel {
    static func mock() -> [CoinFlipDataModel] {
        [CoinFlipDataModel(name: "mockName", image: nil, market_data: MarketData(current_price: CurrentPrice(usd: 100.00)))]
    }
}

