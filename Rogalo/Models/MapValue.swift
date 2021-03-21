//
//  MapValue.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import Foundation

enum MapValue: Value {
    case altitude(altitude: Double?)
    case speed(speed: Double?)
    
    var description: String {
        switch self {
        case .altitude:
            return LocalizedString.mapAltitudeTitle()
        case .speed:
            return LocalizedString.mapSpeedTitle()
        }
    }
    
    var formattedString: String {
        switch self {
        case let .altitude(altitude):
            guard let altitude = altitude else {
                return LocalizedString.deviceValuesEmpty()
            }
            return Formatters.formattedAltitude(for: altitude)
        case let .speed(speed):
            guard let speed = speed, speed > 0 else {
                return LocalizedString.deviceValuesEmpty()
            }
            return Formatters.formattedSpeed(for: speed)
        }
    }
}
