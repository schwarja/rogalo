//
//  DeviceManager.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine
import UIKit

class DeviceManager: DeviceManaging {
    let peripheral: Peripheral
    let bluetoothManager: BluetoothManaging
    let storage: Storage
    let notificationManager: NotificationManaging
    
    private var cancellables = Set<AnyCancellable>()
    
    var device: AnyPublisher<Device, Never> {
        bluetoothManager
            .connectedDevice
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    init(peripheral: Peripheral, bluetoothManager: BluetoothManaging, storage: Storage, notificationManager: NotificationManaging) {
        self.peripheral = peripheral
        self.bluetoothManager = bluetoothManager
        self.storage = storage
        self.notificationManager = notificationManager
        
        setup()
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
    func setup() {
        device
            .compactMap(\.temperature)
            .filter { $0 >= TemperatureSignificantValues.risk.rawValue }
            .compactMap { temperature -> TemperatureSignificantValues? in
                for value in TemperatureSignificantValues.sortedValues where temperature >= value.rawValue {
                    return value
                }
                
                return nil
            }
            .removeDuplicates()
            .debounce(for: .seconds(10), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] value in
                self?.notificationManager.sendNotification(for: .temperatureAlert(type: value))
            }
            .store(in: &cancellables)
    }
}
