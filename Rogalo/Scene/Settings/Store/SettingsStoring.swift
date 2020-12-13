//
//  SettingsStoring.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

protocol SettingsStoring {
    var device: AnyPublisher<Device, Never> { get }
}
