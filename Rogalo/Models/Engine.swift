//
//  Motor.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Foundation

struct Engine {
    static let terminationSequence = "\r\n"
    static let separator = "|"
    
    private var characteristics: [String] = []
    private var incompleteValue = ""
    
    var speed: Int? {
        guard let value = characteristics[safe: EngineCharacteristic.speed.rawValue] else {
            return nil
        }
        
        return Int(value)
    }
    
    var speedMax: Int? {
        guard let value = characteristics[safe: EngineCharacteristic.speedMax.rawValue] else {
            return nil
        }
        
        return Int(value)
    }
    
    var voltage: Double? {
        guard let value = characteristics[safe: EngineCharacteristic.voltage.rawValue] else {
            return nil
        }
        
        return Double(value)
    }
    
    var flightTime: String? {
        guard let hours = characteristics[safe: EngineCharacteristic.flightHours.rawValue] else {
            return nil
        }
        guard let minutes = characteristics[safe: EngineCharacteristic.flightMinutes.rawValue] else {
            return nil
        }
        
        return "\(hours):\(minutes)"
    }
    
    var motoTime: String? {
        guard let hours = characteristics[safe: EngineCharacteristic.motoHours.rawValue] else {
            return nil
        }
        guard let minutes = characteristics[safe: EngineCharacteristic.motoMinutes.rawValue] else {
            return nil
        }

        return "\(hours):\(minutes)"
    }
    
    var temperature: Double? {
        guard let value = characteristics[safe: EngineCharacteristic.temperature.rawValue] else {
            return nil
        }
        
        return Double(value)
    }
    
    var temperatureMax: Double? {
        guard let value = characteristics[safe: EngineCharacteristic.temperatureMax.rawValue] else {
            return nil
        }
        
        return Double(value)
    }

    mutating func append(_ value: String) {
        guard let components = process(value: incompleteValue + value) else {
            incompleteValue += value
            return
        }
        
        incompleteValue = ""
        characteristics = components
    }
}

private extension Engine {
    func process(value: String) -> [String]? {
        guard let range = value.range(of: Self.terminationSequence) else {
            return nil
        }
        
        let prefix = value.prefix(upTo: range.lowerBound)
        
        return prefix.components(separatedBy: Self.separator)
    }
}
