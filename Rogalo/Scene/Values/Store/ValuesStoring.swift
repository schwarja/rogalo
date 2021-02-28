//
//  EngineStoring.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

protocol ValuesStoring {
    var connectionState: AnyPublisher<DeviceState, Never> { get }
    var characteristics: AnyPublisher<[CharacteristicStoring], Never> { get }
}
