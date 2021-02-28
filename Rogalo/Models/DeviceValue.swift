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
    
    var range: DeviceValueRange? {
        switch self {
        case .rpm:
            return DeviceValueRange(min: 0, risk: 8500, critical: 9500)
        case .temperature:
            return DeviceValueRange(min: 0, risk: 185, critical: 195)
        default:
            return nil
        }
    }
    
    var riskProgress: Double? {
        guard let range = range else {
            return nil
        }
        
        return (range.risk-range.min)/(range.critical-range.min)
    }
    
    var progress: Double? {
        guard let range = range else {
            return nil
        }
        
        let value: Double
        switch self {
        case let .rpm(rpm):
            guard let rpm = rpm else {
                return nil
            }
            
            value = Double(rpm)
            
        case let .temperature(temp):
            guard let temp = temp else {
                return nil
            }
            
            value = Double(temp)
            
        default:
            return nil
        }
        
        return (value-range.min)/(range.critical-range.min)
    }
    
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
