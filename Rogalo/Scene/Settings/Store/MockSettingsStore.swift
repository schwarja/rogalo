//
//  MockSettingsStore.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

class MockSettingsStore: SettingsStoring {
    var device: AnyPublisher<Device, Never> {
        Just(.mock).eraseToAnyPublisher()
    }
}
