//
//  BluetoothManaging.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Combine

protocol BluetoothManaging {
    var peripherals: AnyPublisher<[Peripheral], Never> { get }
    var engine: AnyPublisher<Engine?, Never> { get }
    
    func pair(peripheral: Peripheral)
}
