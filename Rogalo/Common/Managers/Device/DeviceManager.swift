//
//  DeviceManager.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine
import UIKit
import UserNotifications

class DeviceManager: DeviceManaging {
    let peripheral: Peripheral
    let bluetoothManager: BluetoothManaging
    let storage: Storage
    
    private var cancellables = Set<AnyCancellable>()
    
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
        
        setup()

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (success, _) in
            print("Notifications: \(success)")
        }
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
    func content(for state: Device.State) -> UNMutableNotificationContent {
        
        let content = UNMutableNotificationContent()
        content.title = "Connection status \(state)"
        switch state {
        case .connected:
            content.sound = UNNotificationSound.default
        case .connecting, .failed:
            content.sound = UNNotificationSound.criticalSoundNamed(UNNotificationSoundName("Intel Chime.mp3"))
        }
        return content
    }
    
    func sendNotification(for status: Device.State) {
        let notification = content(for: status)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notification, trigger: nil)

        UNUserNotificationCenter.current().add(request)
    }

    func setup() {
        device
            .map(\.state)
            .removeDuplicates()
            .sink { [weak self] state in
                self?.sendNotification(for: state)
            }
            .store(in: &cancellables)
    }
}
