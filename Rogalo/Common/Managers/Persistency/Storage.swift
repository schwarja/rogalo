//
//  Storage.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

protocol Storage {
    var battery: CurrentValueSubject<Battery, Never> { get }
    var pairedDevice: CurrentValueSubject<Peripheral?, Never> { get }
    var rpmMultiplier: CurrentValueSubject<Float, Never> { get }
}
