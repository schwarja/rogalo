//
//  SettingsStoring.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

protocol SettingsStoring {
    var model: AnyPublisher<SettingsViewModel, Never> { get }
}
