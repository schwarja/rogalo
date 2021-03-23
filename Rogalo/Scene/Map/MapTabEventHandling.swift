//
//  MapTabEventHandling.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import Foundation

enum MapTabEvent {
    case openSettingsTapped
}

protocol MapTabEventHandling: AnyObject, StatusViewEventHandling {
    func handle(event: MapTabEvent)
}

extension MapTabEventHandling {
    func handle(event: StatusViewEvent) {
        switch event {
        case .openSettingsTapped:
            handle(event: MapTabEvent.openSettingsTapped)
        }
    }
}
