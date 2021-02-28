//
//  NotificationManaging.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Combine
import Foundation

protocol NotificationManaging {
    var authorizationStatus: AnyPublisher<NotificationAuthorizationStatus?, Never> { get }
    
    func sendNotification(for event: NotificationEvent)
}
