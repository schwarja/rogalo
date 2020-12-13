//
//  EngineStoring.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

protocol EngineStoring {
    var engine: AnyPublisher<Device, Never> { get }
}
