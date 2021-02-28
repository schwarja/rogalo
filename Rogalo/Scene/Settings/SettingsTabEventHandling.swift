//
//  SettingsTabEventHandling.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

enum SettingsTabEvent {
    case unpairTapped
    case openSettingsTapped
}

protocol SettingsTabEventHandling: AnyObject, ConnectionStateViewEventHandling, NotificationStateViewEventHandling {
    func handle(event: SettingsTabEvent)
}

extension SettingsTabEventHandling {
    func handle(event: ConnectionStateViewEvent) {
        switch event {
        case .openSettingsTapped:
            handle(event: SettingsTabEvent.openSettingsTapped)
        }
    }
    
    func handle(event: NotificationStateViewEvent) {
        switch event {
        case .openSettingsTapped:
            handle(event: SettingsTabEvent.openSettingsTapped)
        }
    }
}
