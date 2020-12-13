//
//  ContentStore.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

class ContentStore: ContentStoring {
    let deviceManager: DeviceManaging
    
    init(deviceManager: DeviceManaging) {
        self.deviceManager = deviceManager
        
        setup()
    }
    
    var engineStore: EngineStoring {
        EngineStore(deviceManager: deviceManager)
    }
    
    var settingsStore: SettingsStoring {
        SettingsStore(deviceManager: deviceManager)
    }
}

// MARK: - Private
private extension ContentStore {
    func setup() {
        deviceManager.connect()
    }
}
