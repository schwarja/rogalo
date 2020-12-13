//
//  SettingsStore.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

class SettingsStore: SettingsStoring {
    let deviceManager: DeviceManaging
    
    var device: AnyPublisher<Device, Never> {
        deviceManager.device
    }
    
    init(deviceManager: DeviceManaging) {
        self.deviceManager = deviceManager
    }
}
