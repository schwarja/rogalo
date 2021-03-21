//
//  MapCoordinatorEvent.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import Foundation

enum MapCoordinatorEvent {}

protocol MapCoordinatorEventHandling: AnyObject {
    func handle(event: MapCoordinatorEvent)
}
