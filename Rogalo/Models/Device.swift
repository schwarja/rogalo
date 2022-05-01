//
//  Motor.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Foundation

struct Device {
    static let terminationSequence = "\r\n"
    static let separator = "|"
    
    static let mock = Device(peripheral: .mock, state: .connecting)
    
    private var characteristics: [EngineCharacteristic: String] = [:]
    private var incompleteValue = ""
    
    private let peripheral: Peripheral
    
    var id: String {
        peripheral.id
    }
    var name: String {
        peripheral.name
    }
    var state: DeviceState = .connecting {
        didSet {
            stateUpdated()
        }
    }
    var rpmMultiplier: Float = 1
    
    let rpmRange = DeviceValueRange(min: 0, risk: 8500, critical: 9500)
    let engineTemperatureRange = DeviceValueRange(min: 0, risk: 185, critical: 195)
    let exhaustTemperatureRange = DeviceValueRange(min: 0, risk: 500, critical: 600)
    var batteryRange: DeviceValueRange?

    init(peripheral: Peripheral, state: DeviceState) {
        self.peripheral = peripheral
        self.state = state
    }

    mutating func append(_ value: String) {
        guard let components = process(value: incompleteValue + value) else {
            incompleteValue += value
            return
        }
        
        incompleteValue = ""
        characteristics.merge(components, uniquingKeysWith: { $1 })
    }
}

// MARK: - Computed properties {
extension Device {
    var rpm: Int? {
        guard let stringValue = characteristics[.speed] else {
            return nil
        }
        
        guard let value = Float(stringValue) else {
            return nil
        }
        
        return Int(value/rpmMultiplier)
    }
    
    var rpmMax: Int? {
        guard let stringValue = characteristics[.speedMax] else {
            return nil
        }
        
        guard let value = Float(stringValue) else {
            return nil
        }
        
        return Int(value/rpmMultiplier)
    }
    
    var voltage: Double? {
        guard let value = characteristics[.voltage] else {
            return nil
        }
        
        return Double(value)
    }
    
    var isFuelCritical: Bool? {
        guard let value = characteristics[.fuel] else {
            return nil
        }
        
        return value == "1"
    }

    var flightTime: TimeInterval? {
        guard let hoursString = characteristics[.flightHours],
              let hours = TimeInterval(hoursString) else {
            return nil
        }
        guard let minutesString = characteristics[.flightMinutes],
              let minutes = TimeInterval(minutesString) else {
            return nil
        }

        return hours*3600 + minutes*60
    }
    
    var motoTime: TimeInterval? {
        guard let hoursString = characteristics[.motoHours],
              let hours = TimeInterval(hoursString) else {
            return nil
        }
        guard let minutesString = characteristics[.motoMinutes],
              let minutes = TimeInterval(minutesString) else {
            return nil
        }

        return hours*3600 + minutes*60
    }
    
    var temperatureEngine: Double? {
        guard let value = characteristics[.temperatureEngine] else {
            return nil
        }
        
        return Double(value)
    }
    
    var temperatureEngineMax: Double? {
        guard let value = characteristics[.temperatureEngineMax] else {
            return nil
        }
        
        return Double(value)
    }
    
    var temperatureExhaust: Double? {
        guard let value = characteristics[.temperatureExhaust] else {
            return nil
        }
        
        return Double(value)
    }
    
    var temperatureExhaustMax: Double? {
        guard let value = characteristics[.temperatureExhaustMax] else {
            return nil
        }
        
        return Double(value)
    }
}

// MARK: - Processing
private extension Device {
    func process(value: String) -> [EngineCharacteristic: String]? {
        guard let range = value.range(of: Self.terminationSequence) else {
            return nil
        }
        
        let prefix = value.prefix(upTo: range.lowerBound)
        
        var result = [EngineCharacteristic: String]()
        var currentCharacteristic: EngineCharacteristic?
        var currentString = ""
        
        for char in prefix {
            let character = String(char)
            guard let characteristic = EngineCharacteristic.allCases.first(where: { character == $0.rawValue }) else {
                currentString += String(char)
                continue
            }
            
            if let characteristic = currentCharacteristic {
                result[characteristic] = currentString
            }
            
            currentCharacteristic = characteristic
            currentString = ""
        }
        
        if let characteristic = currentCharacteristic {
            result[characteristic] = currentString
        }
        
        return result
    }
    
    mutating func stateUpdated() {
        if state != .connected {
            characteristics.removeAll()
        }
    }
}
