//
//  WebService.swift
//  CryptoApp
//
//  Created by Hüseyin HÖBEK on 26.01.2023.
//

import Foundation

protocol NewsWebServiceProtocol {
    func fetch<T: Codable>(response: T.Type, with path: CoinAPICall, completion: @escaping (Result<T, Error>) -> Void)
}

final class NewsWebService: NewsWebServiceProtocol {
    func fetch<T: Codable>(response: T.Type, with path: CoinAPICall, completion: @escaping (Result<T, Error>) -> Void) {
        let urlRequest = URLRequest(url: path.url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                print("linkden veri gelmedi")
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.dataNotFound))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(T.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

protocol MainWebServiceAdapterProtocol {
    func getCoins(completion: @escaping (Result<Crypto, Error>) -> Void)
}
final class MainWebServiceAdapter: MainWebServiceAdapterProtocol {
    private let webService: NewsWebServiceProtocol
    
    init(webService: NewsWebServiceProtocol) {
        self.webService = webService
    }
    
    func getCoins(completion: @escaping (Result<Crypto, Error>) -> Void) {
        webService.fetch(response: Crypto.self, with: .getCoins, completion: completion)
        
    }
    
}

enum NetworkError: Error {
    case dataNotFound
}

