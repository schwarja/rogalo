//
//  ContentCoordinatorEventHandling.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

enum ContentCoordinatorEvent {}

protocol ContentCoordinatorEventHandling: AnyObject {
    func handle(event: ContentCoordinatorEvent)
}
