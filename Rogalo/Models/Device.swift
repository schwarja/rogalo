//
//  Motor.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Foundation

struct Device {
    enum State: Equatable {
        case connecting
        case connected
        case failed(String)
    }
    
    static let terminationSequence = "\r\n"
    static let separator = "|"
    
    static let mock = Device(peripheral: .mock)
    
    private var characteristics: [String] = []
    private var incompleteValue = ""
    
    private let peripheral: Peripheral
    
    var id: String {
        peripheral.id
    }
    var name: String {
        peripheral.name
    }
    var state: State = .connecting {
        didSet {
            stateUpdated()
        }
    }
    
    var rpm: Int? {
        guard let value = characteristics[safe: EngineCharacteristic.speed.rawValue] else {
            return nil
        }
        
        return Int(value)
    }
    
    var rpmMax: Int? {
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
    
    init(peripheral: Peripheral) {
        self.peripheral = peripheral
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
