//
//  DeviceValueRange.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import Foundation

struct DeviceValueRange: Codable, Equatable {
    let min: Double
    let risk: Double
    let critical: Double
    
    var order: Order {
        min < critical ? .asceding : .descending
    }
}
