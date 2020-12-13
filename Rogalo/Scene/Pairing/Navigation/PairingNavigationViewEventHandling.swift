//
//  PairingNavigationViewEventHandling.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

enum PairingNavigationViewEvent {
    case openSettings
}

protocol PairingNavigationViewEventHandling: AnyObject {
    func handle(event: PairingNavigationViewEvent)
}
