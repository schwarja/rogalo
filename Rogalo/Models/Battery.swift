//
//  Battery.swift
//  Rogalo
//
//  Created by Jan on 07.03.2021.
//

import Foundation

struct Battery: Codable {
    struct Range: Codable {
        let minimum: Double
        let optimum: Double
        let maximum: Double
    }
    
    enum BatteryType: String, Codable {
        case lipo
        case nicd
        case custom
        
        var range: Range? {
            switch self {
            case .lipo:
                return Range(minimum: 12, optimum: 14.8, maximum: 16.8)
            case .nicd:
                return Range(minimum: 13.6, optimum: 19.2, maximum: 21.6)
            case .custom:
                return nil
            }
        }
    }
    
    let type: BatteryType
    let range: Range
    
    init(type: BatteryType, range: Range? = nil) {
        self.type = type
        
        if let range = range {
            self.range = range
        } else if let range = type.range {
            self.range = range
        } else {
            fatalError("Missing range")
        }
    }
}
