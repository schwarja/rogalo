//
//  RecordsCoordinatorEventHandling.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Foundation

enum RecordsCoordinatorEvent {}

protocol RecordsCoordinatorEventHandling: AnyObject {
    func handle(event: RecordsCoordinatorEvent)
}
