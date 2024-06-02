//
//  AirTicketsData.swift
//  EffectiveMobile
//
//  Created by Марат Хасанов on 31.05.2024.
//

import Foundation

struct Object: Codable {
    let offers: [Offers]
}

struct Offers: Codable {
    let id: Int
    let title: String
    let town: String
    let price: Price
}

struct Price: Codable {
    let value: Int
}
