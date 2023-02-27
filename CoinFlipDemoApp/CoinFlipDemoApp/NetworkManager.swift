//
//  NetworkManager.swift
//  CoinFlipDemoApp
//
//  Created by Ashish Singh on 2/26/23.
//

import Foundation

protocol NetworkHandler {
    func fetchData(completion: @escaping (Result<[CoinFlipDataModel], AppErrors>) -> Void)
}

enum AppErrors: Error {
    case network
    case partial
}

class NetworkManager: NetworkHandler {
    func fetchData(completion: @escaping (Result<[CoinFlipDataModel], AppErrors>) -> Void) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/") else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil  else {
                return completion(.failure(.network))
            }
            
            do {
                let data = try JSONDecoder().decode([CoinFlipDataModel].self, from: data)
                completion(.success(data))
            } catch {
                completion(.failure(.network))
            }
        }.resume()
    }
}
