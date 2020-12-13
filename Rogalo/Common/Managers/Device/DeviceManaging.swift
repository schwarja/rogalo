//
//  DeviceManaging.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

protocol DeviceManaging {
    var device: AnyPublisher<Device, Never> { get }
    
    func connect()
    func forgetDevice()
}
