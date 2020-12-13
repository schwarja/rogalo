//
//  DeviceManager.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

class DeviceManager: DeviceManaging {
    let peripheral: Peripheral
    let bluetoothManager: BluetoothManaging
    let storage: Storage
    
    var device: AnyPublisher<Device, Never> {
        bluetoothManager
            .connectedDevice
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    init(peripheral: Peripheral, bluetoothManager: BluetoothManaging, storage: Storage) {
        self.peripheral = peripheral
        self.bluetoothManager = bluetoothManager
        self.storage = storage
    }
    
    func connect() {
        bluetoothManager.connect(peripheral: peripheral)
    }
    
    func forgetDevice() {
        bluetoothManager.disconnect(peripheral: peripheral)
        storage.pairedDevice.value = nil
    }
}

// MARK: - Private methods
private extension DeviceManager {
}
