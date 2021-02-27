//
//  CharacteristicsCoordinatorEventHandling.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

enum ValuesCoordinatorEvent {}

protocol ValuesCoordinatorEventHandling: AnyObject {
    func handle(event: ValuesCoordinatorEvent)
}
