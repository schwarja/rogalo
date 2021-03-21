//
//  StatusViewEvent.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import Foundation

protocol StatusViewEventHandling {
    func handle(event: StatusViewEvent)
}

enum StatusViewEvent {
    case openSettingsTapped
}
