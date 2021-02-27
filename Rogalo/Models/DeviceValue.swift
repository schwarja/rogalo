//
//  DeviceValue.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Foundation

enum DeviceValue: Hashable {
    case rpm(value: Int?)
    case rpmMax(value: Int?)
    case voltage(value: Double?)
    case flightTime(value: TimeInterval?)
    case motoTime(value: TimeInterval?)
    case temperature(value: Double?)
    case temperatureMax(value: Double?)
    
    var description: String {
        switch self {
        case .flightTime:
            return "Flight time"
        case .motoTime:
            return "Moto time"
        case .rpm:
            return "Engine speed"
        case .rpmMax:
            return "Maximum engine speed"
        case .temperature:
            return "Temperature"
        case .temperatureMax:
            return "Maximum temperature"
        case .voltage:
            return "Voltage"
        }
    }
    
    var formattedString: String {
        switch self {
        case let .rpm(value), let .rpmMax(value):
            guard let rpm = value else {
                return "-"
            }
            
            return "\(rpm) RPM"
            
        case let .flightTime(value), let .motoTime(value):
            guard let time = value else {
                return "-"
            }
            
            return Formatters.flightTimeFormatter.string(from: time) ?? "-"
            
        case .temperature(let value), .temperatureMax(let value):
            guard let temperature = value else {
                return "-"
            }
            
            return Formatters.formattedTemperature(for: temperature)
            
        case let .voltage(value):
            guard let voltage = value else {
                return "-"
            }
            
            return Formatters.formattedVoltage(for: voltage)
        }
    }
}
