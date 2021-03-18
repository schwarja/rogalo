//
//  CharacteristicStore.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import SwiftUI

struct CharacteristicStore: CharacteristicStoring {
    typealias Range = (min: Double, mid: Double, max: Double)
    
    let value: DeviceValue
    let range: DeviceValueRange?
    
    var normalizedRange: Range? {
        guard let range = range else {
            return nil
        }
        
        switch range.order {
        case .asceding:
            return (range.min, range.risk, range.critical)
        case .descending:
            return (range.critical, range.risk, range.min)
        }
    }

    var riskProgress: Double? {
        guard let range = normalizedRange else {
            return nil
        }
        
        return (range.mid-range.min)/(range.max-range.min)
    }
    
    var progress: Double? {
        guard let range = normalizedRange else {
            return nil
        }
        
        let number: Double
        switch value {
        case let .rpm(rpm):
            number = Double(rpm)
            
        case let .temperatureEngine(temp):
            number = temp
            
        case let .voltage(voltage):
            number = voltage
            
        default:
            return nil
        }
        
        return (number-range.min)/(range.max-range.min)
    }

    var formattedValue: String {
        value.formattedString
    }
    
    var valueDescription: String {
        value.description
    }
    
    var scale: CharacteristicScale? {
        guard let risk = riskProgress, let progress = progress, let order = range?.order else {
            return nil
        }
        
        return CharacteristicScale(midLocation: CGFloat(risk), progress: CGFloat(progress), order: order)
    }
    
    init(value: DeviceValue, range: DeviceValueRange? = nil) {
        self.value = value
        self.range = range
    }
}
