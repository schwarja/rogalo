//
//  DeviceValue.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Foundation

enum DeviceValue: Hashable {
    case rpm(value: Int)
    case rpmMax(value: Int)
    case voltage(value: Double)
    case flightTime(value: TimeInterval)
    case motoTime(value: TimeInterval)
    case temperatureEngine(value: Double)
    case temperatureEngineMax(value: Double)
    case temperatureExhaust(value: Double)
    case temperatureExhaustMax(value: Double)

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
        case .temperatureEngine:
            return LocalizedString.deviceValuesTemperatureEngine()
        case .temperatureEngineMax:
            return LocalizedString.deviceValuesTemperatureEngineMax()
        case .temperatureExhaust:
            return LocalizedString.deviceValuesTemperatureExhaust()
        case .temperatureExhaustMax:
            return LocalizedString.deviceValuesTemperatureExhaustMax()
        case .voltage:
            return LocalizedString.deviceValuesVoltage()
        }
    }
    
    var formattedString: String {
        switch self {
        case let .rpm(rpm), let .rpmMax(rpm):
            return "\(rpm) \(LocalizedString.deviceValuesEngineSpeedRpm())"
            
        case let .flightTime(time), let .motoTime(time):
            return Formatters.flightTimeFormatter.string(from: time) ?? LocalizedString.deviceValuesEmpty()
            
        case .temperatureEngine(let temp), .temperatureEngineMax(let temp), .temperatureExhaust(let temp), .temperatureExhaustMax(let temp):
            return Formatters.formattedTemperature(for: temp)
            
        case let .voltage(voltage):
            return Formatters.formattedVoltage(for: voltage)
        }
    }
}
