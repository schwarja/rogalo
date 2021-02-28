//
//  PairingCoordinator.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import UIKit

class PairingCoordinator {
    let container: DependencyContainer
    var childCoordinators: [Coordinator]  = []
    weak var parent: PairingCoordinatorEventHandling?
    
    lazy var rootView: PairingNavigationView = makePairingScene()
    lazy var store: PairingStore = makePairingStore()
    
    init(container: DependencyContainer, parent: PairingCoordinatorEventHandling) {
        self.container = container
        self.parent = parent
    }
}

// MARK: - Coordinator
extension PairingCoordinator: ViewCoordinator {
    func start() {}
}

extension PairingCoordinator: PairingNavigationViewEventHandling {
    func handle(event: PairingNavigationViewEvent) {
        switch event {
        case .openSettings:
            if UIApplication.shared.canOpenURL(Constants.settingsUrl) {
                UIApplication.shared.open(Constants.settingsUrl)
            }
        }
    }
}

// MARK: - Factories
private extension PairingCoordinator {
    func makePairingScene() -> PairingNavigationView {
        PairingNavigationView(store: store, coordinator: self)
    }
    
    func makePairingStore() -> PairingStore {
        PairingStore(bluetoothManager: container[.bluetoothManager], storage: container[.storage])
    }
}
