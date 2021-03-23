//
//  DeviceValueStore.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import SwiftUI

struct DeviceValueStore: DeviceValueStoring {
    typealias Range = (min: Double, mid: Double, max: Double)
    
    let deviceValue: DeviceValue
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
        switch deviceValue {
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
    
    var scale: ValueScale? {
        guard let risk = riskProgress, let progress = progress, let order = range?.order else {
            return nil
        }
        
        return ValueScale(midLocation: CGFloat(risk), progress: CGFloat(progress), order: order)
    }
    
    init(value: DeviceValue, range: DeviceValueRange? = nil) {
        self.deviceValue = value
        self.range = range
    }
}
