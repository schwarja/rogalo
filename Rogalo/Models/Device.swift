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
    
    private var characteristics: [String] = []
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
        characteristics = components
    }
}

// MARK: - Computed properties {
extension Device {
    var rpm: Int? {
        guard let stringValue = characteristics[safe: EngineCharacteristic.speed.rawValue] else {
            return nil
        }
        
        guard let value = Float(stringValue) else {
            return nil
        }
        
        return Int(value/rpmMultiplier)
    }
    
    var rpmMax: Int? {
        guard let stringValue = characteristics[safe: EngineCharacteristic.speedMax.rawValue] else {
            return nil
        }
        
        guard let value = Float(stringValue) else {
            return nil
        }
        
        return Int(value/rpmMultiplier)
    }
    
    var voltage: Double? {
        guard let value = characteristics[safe: EngineCharacteristic.voltage.rawValue] else {
            return nil
        }
        
        return Double(value)
    }
    
    var flightTime: TimeInterval? {
        guard let hoursString = characteristics[safe: EngineCharacteristic.flightHours.rawValue],
              let hours = TimeInterval(hoursString) else {
            return nil
        }
        guard let minutesString = characteristics[safe: EngineCharacteristic.flightMinutes.rawValue],
              let minutes = TimeInterval(minutesString) else {
            return nil
        }

        return hours*3600 + minutes*60
    }
    
    var motoTime: TimeInterval? {
        guard let hoursString = characteristics[safe: EngineCharacteristic.motoHours.rawValue],
              let hours = TimeInterval(hoursString) else {
            return nil
        }
        guard let minutesString = characteristics[safe: EngineCharacteristic.motoMinutes.rawValue],
              let minutes = TimeInterval(minutesString) else {
            return nil
        }

        return hours*3600 + minutes*60
    }
    
    var temperatureEngine: Double? {
        guard let value = characteristics[safe: EngineCharacteristic.temperatureEngine.rawValue] else {
            return nil
        }
        
        return Double(value)
    }
    
    var temperatureEngineMax: Double? {
        guard let value = characteristics[safe: EngineCharacteristic.temperatureEngineMax.rawValue] else {
            return nil
        }
        
        return Double(value)
    }
    
    var temperatureExhaust: Double? {
        guard let value = characteristics[safe: EngineCharacteristic.temperatureExhaust.rawValue] else {
            return nil
        }
        
        return Double(value)
    }
    
    var temperatureExhaustMax: Double? {
        guard let value = characteristics[safe: EngineCharacteristic.temperatureExhaustMax.rawValue] else {
            return nil
        }
        
        return Double(value)
    }
}

// MARK: - Processing
private extension Device {
    func process(value: String) -> [String]? {
        guard let range = value.range(of: Self.terminationSequence) else {
            return nil
        }
        
        let prefix = value.prefix(upTo: range.lowerBound)
        
        return prefix.components(separatedBy: Self.separator)
    }
    
    mutating func stateUpdated() {
        if state != .connected {
            characteristics.removeAll()
        }
    }
}
