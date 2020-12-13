//
//  SettingsCoordinator.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

class SettingsCoordinator: Coordinator {
    let container: DependencyContainer
    var childCoordinators: [Coordinator]  = []
    weak var parent: SettingsCoordinatorEventHandling?
    
    lazy var rootView: SettingsTab = makeSettingsScene()
    lazy var store: SettingsStore = makeSettingsStore()
    
    init(container: DependencyContainer, parent: SettingsCoordinatorEventHandling) {
        self.container = container
        self.parent = parent
    }
}

// MARK: - Coordinator
extension SettingsCoordinator: ViewCoordinator {
    func start() {}
}

// MARK: - Settings tab event handling
extension SettingsCoordinator: SettingsTabEventHandling {
    func handle(event: SettingsTabEvent) {
        switch event {
        case .unpair:
            let deviceManager: DeviceManaging = container[.deviceManager]
            deviceManager.forgetDevice()
        }
    }
}

// MARK: - Factories
private extension SettingsCoordinator {
    func makeSettingsScene() -> SettingsTab {
        SettingsTab(store: store, coordinator: self)
    }
    
    func makeSettingsStore() -> SettingsStore {
        SettingsStore(deviceManager: container[.deviceManager])
    }
}
