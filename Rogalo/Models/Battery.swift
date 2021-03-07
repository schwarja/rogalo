//
//  Battery.swift
//  Rogalo
//
//  Created by Jan on 07.03.2021.
//

import Foundation

struct Battery: Codable {
    enum BatteryType: String, Codable {
        case lipo
        case nicd
        case custom
        
        var range: DeviceValueRange? {
            switch self {
            case .lipo:
                return DeviceValueRange(min: 16.8, risk: 14.8, critical: 12)
            case .nicd:
                return DeviceValueRange(min: 21.6, risk: 19.2, critical: 13.6)
            case .custom:
                return nil
            }
        }
    }
    
    let type: BatteryType
    let range: DeviceValueRange
    
    init(type: BatteryType, range: DeviceValueRange? = nil) {
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
