//
//  NotificationEvent.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Foundation

enum NotificationEvent {
    case temperatureAlert(type: TemperatureSignificantValues)
    case exhaustAlert(type: ExhaustSignificantValues)
}
