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
            .combineLatest(storage.rpmMultiplier)
            .compactMap { device, multiplier -> Device? in
                var copy = device
                copy?.rpmMultiplier = multiplier
                return copy
            }
            .combineLatest(storage.battery)
            .map { device, battery -> Device in
                var copy = device
                copy.batteryRange = battery.range
                return copy
            }
            .share()
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
            .compactMap(\.temperatureEngine)
            .removeDuplicates()
            .compactMap { temperature -> EngineTemperatureSignificantEvents? in
                for value in EngineTemperatureSignificantEvents.sortedValues where temperature >= value.rawValue {
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
        
        device
            .map(\.state)
            .removeDuplicates()
            .map { state -> ConnectivitySignificantEvents in
                state == .connected ? .connected : .disconnected
            }
            .removeDuplicates()
            .sink { [weak self] value in
                self?.notificationManager.sendNotification(for: .connectivityEvent(type: value))
            }
            .store(in: &cancellables)

        Publishers.CombineLatest(storage.battery, device.compactMap(\.voltage))
            .map { battery, voltage -> GeneralSignificantEvents? in
                voltage < battery.range.min ? .notCharging : nil
            }
            .removeDuplicates()
            .debounce(for: .seconds(10), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] value in
                guard let value = value else {
                    return
                }
                
                self?.notificationManager.sendNotification(for: .general(type: value))
            }
            .store(in: &cancellables)

        device.compactMap(\.isFuelCritical)
            .removeDuplicates()
            .map { fuel -> GeneralSignificantEvents? in
                fuel ? .outOfFuel : nil
            }
            .removeDuplicates()
            .debounce(for: .seconds(10), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] value in
                guard let value = value else {
                    return
                }
                
                self?.notificationManager.sendNotification(for: .general(type: value))
            }
            .store(in: &cancellables)
   }
}
