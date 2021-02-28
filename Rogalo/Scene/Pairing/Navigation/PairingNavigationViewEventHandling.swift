//
//  PairingNavigationViewEventHandling.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

enum PairingNavigationViewEvent {
    case openSettings
    case didSelect(peripheral: Peripheral)
}

protocol PairingNavigationViewEventHandling: AnyObject, PeriperalListViewEventHandling {
    func handle(event: PairingNavigationViewEvent)
}

extension PairingNavigationViewEventHandling {
    func handle(event: PeriperalListViewEvent) {
        switch event {
        case .openSettingsTapped:
            handle(event: PairingNavigationViewEvent.openSettings)
        case .didSelect(let peripheral):
            handle(event: PairingNavigationViewEvent.didSelect(peripheral: peripheral))
        }
    }
}
