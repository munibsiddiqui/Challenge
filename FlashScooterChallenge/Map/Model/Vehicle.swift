//
//  Vehicle.swift
//  FlashScooterChallenge
//
//  Created by Munib Siddiqui on 09/07/2019.
//  Copyright © 2019 Munib Siddiqui. All rights reserved.
//

import Foundation

// MARK: - Vehicle
struct Vehicle: Codable {
    let id: Int
    let name, vehicleDescription: String
    let latitude, longitude: Double
    let batteryLevel: Int
    let timestamp: Date
    let price, priceTime: Int
    let currency: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case vehicleDescription = "description"
        case latitude, longitude, batteryLevel, timestamp, price, priceTime, currency
    }
}

