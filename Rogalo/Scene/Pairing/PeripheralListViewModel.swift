//
//  PeripheralListViewModel.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import Foundation

struct PeripheralListViewModel {
    let connectionState: DeviceState
    let peripherals: [Peripheral]
    
    static let empty = PeripheralListViewModel(connectionState: .connecting, peripherals: [])
}
