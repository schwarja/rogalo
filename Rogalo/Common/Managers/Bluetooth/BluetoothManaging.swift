//
//  BluetoothManaging.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Combine

enum BluetoothStatus {
    case initial
    case unauthorized
    case notAvailable
    case scanning
}

protocol BluetoothManaging {
    var status: AnyPublisher<BluetoothStatus, Never> { get }
    var peripherals: AnyPublisher<[Peripheral], Never> { get }
    var connectedDevice: AnyPublisher<Device?, Never> { get }
    
    func connect(peripheral: Peripheral)
    func disconnect(peripheral: Peripheral)
}
