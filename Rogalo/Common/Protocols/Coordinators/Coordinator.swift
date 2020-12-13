//
//  Coordinator.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

protocol Coordinator: AnyObject {
    var container: DependencyContainer { get }
    var childCoordinators: [Coordinator] { get set }

    func start()
}
