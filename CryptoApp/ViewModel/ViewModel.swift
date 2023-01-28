//
//  ViewModel.swift
//  CryptoApp
//
//  Created by Hüseyin HÖBEK on 26.01.2023.
//

import Foundation

final class MainViewModel {
    
    var cryptoList: DataClass?
    
    private let webService: MainWebServiceAdapter
    
    init(webService: MainWebServiceAdapter) {
        self.webService = webService
    }
    func getSparklineMinMax(index: Int) -> (min: Double, max: Double) {
        let sparkline = cryptoList?.coins![index].sparkline
        let min = Double((sparkline?.min())!)
        let max = Double((sparkline?.max())!)
        return (min!, max!)
    }
    
    func getCoin(completionHandler: @escaping () -> Void) {
        webService.getCoins { result in
            switch result {
            case .success(let response):
                if let coins = response.data {
                    self.cryptoList = coins
                }
                completionHandler()
            case .failure(let error):
                print(error)
            }
        }
    }
}

