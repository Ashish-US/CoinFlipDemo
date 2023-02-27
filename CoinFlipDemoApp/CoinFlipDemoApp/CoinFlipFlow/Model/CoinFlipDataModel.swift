//
//  CoinFlipDataModel.swift
//  CoinFlipDemoApp
//
//  Created by Ashish Singh on 2/25/23.
//

import Foundation

struct ImageDataModel: Codable {
    var thumb: String?
}

struct CurrentPrice: Codable {
    var usd: Double?
}

struct MarketData: Codable {
    var current_price: CurrentPrice?
}

struct CoinFlipDataModel: Decodable {
    var name: String?
    var image: ImageDataModel?
    var market_data: MarketData?
}

extension CoinFlipDataModel: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name
    }
}
