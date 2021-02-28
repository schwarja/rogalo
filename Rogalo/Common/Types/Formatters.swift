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
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1

        let formatter = MeasurementFormatter()
        formatter.numberFormatter = numberFormatter

        return formatter
    }()
    
    static func formattedTemperature(for temperature: Double) -> String {
        let measurement = Measurement(
            value: temperature,
            unit: UnitTemperature.celsius
        )

        return measurementFormatter.string(from: measurement)
    }
    
    static func formattedVoltage(for voltage: Double) -> String {
        let measurement = Measurement(
            value: voltage,
            unit: UnitElectricPotentialDifference.volts
        )

        return measurementFormatter.string(from: measurement)
    }
}
