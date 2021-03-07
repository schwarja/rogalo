//
//  DependencyContainer.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

typealias DeviceManagerRetriever = (_ peripheral: Peripheral) -> DeviceManaging

enum DependencyType {
    case bluetoothManager
    case deviceManager
    case deviceManagerRegistration
    case storage
    case notifications
    case settingsService
}

protocol DependencyContainer {
    func register(_ dependency: Any, for type: DependencyType)
    func resolve<T>(type: DependencyType) -> T
    func unregister(type: DependencyType)
}

extension DependencyContainer {
    subscript<T>(_ type: DependencyType) -> T {
        resolve(type: type)
    }
}
