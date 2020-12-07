//
//  PairingStoreState.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Foundation

enum PairingStoreState {
    case initial
    case loading
    case ready(data: [Peripheral])
}
