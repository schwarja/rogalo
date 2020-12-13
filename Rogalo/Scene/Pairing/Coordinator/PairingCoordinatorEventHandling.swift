//
//  PairingCoordinatorEventHandling.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

enum PairingCoordinatorEvent {}

protocol PairingCoordinatorEventHandling: AnyObject {
    func handle(event: PairingCoordinatorEvent)
}
