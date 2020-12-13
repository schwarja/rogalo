//
//  MockEngineStore.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

class MockEngineStore: EngineStoring {
    let device = CurrentValueSubject<Device, Never>(.mock)
    var engine: AnyPublisher<Device, Never> {
        device.eraseToAnyPublisher()
    }
}
