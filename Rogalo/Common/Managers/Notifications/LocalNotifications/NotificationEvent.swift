//
//  NotificationEvent.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Foundation

enum NotificationEvent {
    case general(type: GeneralSignificantEvents)
    case temperatureAlert(type: EngineTemperatureSignificantEvents)
    case exhaustAlert(type: ExhaustSignificantValues)
    case connectivityEvent(type: ConnectivitySignificantEvents)
}
