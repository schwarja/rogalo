//
//  SettingsCoordinatorEventHandling.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

enum SettingsCoordinatorEvent {}

protocol SettingsCoordinatorEventHandling: AnyObject {
    func handle(event: SettingsCoordinatorEvent)
}
