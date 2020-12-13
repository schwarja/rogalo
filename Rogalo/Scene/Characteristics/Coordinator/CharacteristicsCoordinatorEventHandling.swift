//
//  CharacteristicsCoordinatorEventHandling.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

enum CharacteristicsCoordinatorEvent {
}

protocol CharacteristicsCoordinatorEventHandling: AnyObject {
    func handle(event: CharacteristicsCoordinatorEvent)
}
