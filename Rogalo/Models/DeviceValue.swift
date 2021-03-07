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
            return LocalizedString.deviceValuesFlightTime()
        case .motoTime:
            return LocalizedString.deviceValuesMotoTime()
        case .rpm:
            return LocalizedString.deviceValuesEngineSpeed()
        case .rpmMax:
            return LocalizedString.deviceValuesEngineSpeedMax()
        case .temperature:
            return LocalizedString.deviceValuesTemperature()
        case .temperatureMax:
            return LocalizedString.deviceValuesTemperatureMax()
        case .voltage:
            return LocalizedString.deviceValuesVoltage()
        }
    }
    
    var formattedString: String {
        switch self {
        case let .rpm(value), let .rpmMax(value):
            guard let rpm = value else {
                return LocalizedString.deviceValuesEmpty()
            }
            
            return "\(rpm) \(LocalizedString.deviceValuesEngineSpeedRpm())"
            
        case let .flightTime(value), let .motoTime(value):
            guard let time = value else {
                return LocalizedString.deviceValuesEmpty()
            }
            
            return Formatters.flightTimeFormatter.string(from: time) ?? LocalizedString.deviceValuesEmpty()
            
        case .temperature(let value), .temperatureMax(let value):
            guard let temperature = value else {
                return LocalizedString.deviceValuesEmpty()
            }
            
            return Formatters.formattedTemperature(for: temperature)
            
        case let .voltage(value):
            guard let voltage = value else {
                return LocalizedString.deviceValuesEmpty()
            }
            
            return Formatters.formattedVoltage(for: voltage)
        }
    }
}
