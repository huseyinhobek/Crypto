//
//  Model.swift
//  CryptoApp
//
//  Created by Hüseyin HÖBEK on 26.01.2023.
//

import Foundation


// MARK: - Crypto
struct Crypto: Codable {
    let status: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let stats: Stats?
    var coins: [Coin]?
}

// MARK: - Coin
struct Coin: Codable {
    let uuid, symbol, name: String?
    let color: String?
    let iconUrl: String?
    let marketCap, price: String?
    let listedAt, tier: Int?
    let change: String?
    let rank: Int?
    let sparkline: [String]?
    let lowVolume: Bool?
    let coinrankingUrl: String?
    let the24HVolume, btcPrice: String?

    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color
        case iconUrl = "iconUrl"
        case marketCap, price, listedAt, tier, change, rank, sparkline, lowVolume
        case coinrankingUrl = "coinrankingUrl"
        case the24HVolume = "24hVolume"
        case btcPrice
    }
}

// MARK: - Stats
struct Stats: Codable {
    let total, totalCoins, totalMarkets, totalExchanges: Int?
    let totalMarketCap, total24HVolume: String?

    enum CodingKeys: String, CodingKey {
        case total, totalCoins, totalMarkets, totalExchanges, totalMarketCap
        case total24HVolume = "total24hVolume"
    }
}

enum SortType: String {
    case price = "Price"
    case marketCap = "Market Cap"
    case volume24 = "24h Vol"
    case change =  "Change"
}
