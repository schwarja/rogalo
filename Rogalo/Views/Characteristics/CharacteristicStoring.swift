//
//  CharacteristicStoring.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Foundation

protocol CharacteristicStoring {
    var value: DeviceValue { get }
    var formattedValue: String { get }
    var valueDescription: String { get }
    
    var scale: CharacteristicScale? { get }
}
