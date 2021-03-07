//
//  RevolutionsManaging.swift
//  Rogalo
//
//  Created by Jan on 07.03.2021.
//

import Combine

protocol SettingsServicing {
    var revolutionsMultipliers: [Float] { get }
    var revolutionsMultiplier: CurrentValueSubject<Float, Never> { get }
}
