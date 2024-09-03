//
//  Coin.swift
//  TransitionNetwork
//
//  Created by J Oh on 9/3/24.
//

import Foundation

struct Coin: Hashable, Codable {
    let market, koreanName, englishName: String

    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}
