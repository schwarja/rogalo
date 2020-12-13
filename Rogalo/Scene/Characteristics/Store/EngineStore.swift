//
//  EngineStore.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Combine

class EngineStore: EngineStoring {
    var engine: AnyPublisher<Device, Never> {
        deviceManager.device
    }
    
    let deviceManager: DeviceManaging
    
    private var cancellables = Set<AnyCancellable>()
    
    init(deviceManager: DeviceManaging) {
        self.deviceManager = deviceManager
    }
}
