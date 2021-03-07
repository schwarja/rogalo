//
//  SettingsServicing.swift
//  Rogalo
//
//  Created by Jan on 07.03.2021.
//

import Combine

protocol SettingsServicing {
    var rpmMultipliers: [Float] { get }
    var rpmMultiplier: CurrentValueSubject<Float, Never> { get }
}
