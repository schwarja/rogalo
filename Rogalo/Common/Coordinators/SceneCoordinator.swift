//
//  SceneCoordinator.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine
import SwiftUI

final class SceneCoordinator {
    var childCoordinators = [Coordinator]()

    let container: DependencyContainer
    
    private let window: UIWindow
    private var cancellables = Set<AnyCancellable>()

    init(window: UIWindow, container: DependencyContainer) {
        self.window = window
        self.container = container
    }
}

// MARK: - Scene Coordinating
extension SceneCoordinator: SceneCoordinating {
    func start() {
        let storage: Storage = container[.storage]
        
        storage.pairedDevice
            .removeDuplicates()
            .sink { [weak self] peripheral in
                guard let self = self else {
                    return
                }
                
                self.childCoordinators.removeAll()
                
                let root: (coordinator: Coordinator, controller: UIViewController)
                if let peripheral = peripheral {
                    let retrieveClosure: DeviceManagerRetriever = self.container[.deviceManagerRegistration]
                    self.container.register(retrieveClosure(peripheral), for: .deviceManager)
                    root = self.makeContentScene()
                } else {
                    root = self.makePairingScene()
                    self.container.unregister(type: .deviceManager)
                }
                
                self.childCoordinators.append(root.coordinator)
                root.coordinator.start()
                
                self.window.rootViewController = root.controller
                self.window.makeKeyAndVisible()
            }
            .store(in: &cancellables)
    }
}

// MARK: - Pairing coordinator event handling {
extension SceneCoordinator: PairingCoordinatorEventHandling {
    func handle(event: PairingCoordinatorEvent) {
        
    }
}

// MARK: - Pairing coordinator event handling {
extension SceneCoordinator: ContentCoordinatorEventHandling {
    func handle(event: ContentCoordinatorEvent) {
        
    }
}

// MARK: - Factories
private extension SceneCoordinator {
    func makePairingScene() -> (coordinator: Coordinator, controller: UIViewController) {
        let coordinator = PairingCoordinator(container: container, parent: self)

        let controller = UIHostingController(rootView: coordinator.rootView)

        return (coordinator, controller)
    }
    
    func makeContentScene() -> (coordinator: Coordinator, controller: UIViewController) {
        let coordinator = ContentCoordinator(container: container, parent: self)

        let controller = UIHostingController(rootView: coordinator.rootView)

        return (coordinator, controller)
    }
}

// MARK: - Private methods
private extension SceneCoordinator {
    
}
