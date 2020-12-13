//
//  SettingsTabEventHandling.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

enum SettingsTabEvent {
    case unpair
}

protocol SettingsTabEventHandling: AnyObject {
    func handle(event: SettingsTabEvent)
}
