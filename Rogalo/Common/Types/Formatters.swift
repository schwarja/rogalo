//
//  Formatters.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Foundation

enum Formatters {
    static let flightTimeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        formatter.zeroFormattingBehavior = .dropLeading
        
        return formatter
    }()
    
    static let measurementFormatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()

        return formatter
    }()
    
    static func formattedTemperature(for temperature: Double) -> String {
        let measurement = Measurement(
            value: temperature,
            unit: UnitTemperature.celsius
        )
        
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        measurementFormatter.numberFormatter = numberFormatter

        return measurementFormatter.string(from: measurement)
    }
    
    static func formattedVoltage(for voltage: Double) -> String {
        let measurement = Measurement(
            value: voltage,
            unit: UnitElectricPotentialDifference.volts
        )
        
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1
        measurementFormatter.numberFormatter = numberFormatter

        return measurementFormatter.string(from: measurement)
    }
    
    static func formattedSpeed(for speed: Double) -> String {
        let measurement = Measurement(
            value: speed,
            unit: UnitSpeed.metersPerSecond
        )
        
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        measurementFormatter.numberFormatter = numberFormatter

        return measurementFormatter.string(from: measurement)
    }
    
    static func formattedAltitude(for length: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        
        let formatter = MeasurementFormatter()
        formatter.numberFormatter = numberFormatter
        formatter.unitStyle = .medium
        formatter.unitOptions = .providedUnit
        
        var measurement = Measurement(value: length, unit: UnitLength.meters)
        if !Locale.current.usesMetricSystem {
            measurement.convert(to: .feet)
        }

        return formatter.string(from: measurement)
    }
}
