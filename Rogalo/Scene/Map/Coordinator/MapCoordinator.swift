//
//  MapCoordinator.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import SwiftUI

class MapCoordinator: Coordinator {
    let container: DependencyContainer
    var childCoordinators: [Coordinator]  = []
    weak var parent: MapCoordinatorEventHandling?
    
    lazy var rootView: MapTab = makeMapScene()
    lazy var store: MapStoring = makeMapStore()
    
    init(container: DependencyContainer, parent: MapCoordinatorEventHandling) {
        self.container = container
        self.parent = parent
    }
}

// MARK: - Coordinator
extension MapCoordinator: ViewCoordinator {
    func start() {}
}

// MARK: - Map tab event handling
extension MapCoordinator: MapTabEventHandling {
    func handle(event: MapTabEvent) {
        switch event {
        case .openSettingsTapped:
            if UIApplication.shared.canOpenURL(Constants.settingsUrl) {
                UIApplication.shared.open(Constants.settingsUrl)
            }
        }
    }
}

// MARK: - Factories
private extension MapCoordinator {
    func makeMapScene() -> MapTab {
        MapTab(store: store, coordinator: self)
    }
    
    func makeMapStore() -> MapStore {
        MapStore(locationManager: container[.locationManager])
    }
}
