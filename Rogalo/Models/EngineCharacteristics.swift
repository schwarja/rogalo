//
//  EngineCharacteristics.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Foundation

enum EngineCharacteristic: String, CaseIterable {
    case speed = "A"
    case speedMax = "B"
    case voltage = "L"
    case flightMinutes = "I"
    case flightHours = "J"
    case motoMinutes = "H"
    case motoHours = "G"
    case temperatureEngineMax = "D"
    case temperatureEngine = "C"
    case fuel = "K"
    case temperatureExhaust = "E"
    case temperatureExhaustMax = "F"
    case firmware = "M"
}
