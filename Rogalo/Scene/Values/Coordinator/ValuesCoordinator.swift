//
//  CharacteristicsCoordinator.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

class ValuesCoordinator: Coordinator {
    let container: DependencyContainer
    var childCoordinators: [Coordinator]  = []
    weak var parent: ValuesCoordinatorEventHandling?
    
    lazy var rootView: ValuesTab = makeCharacteristicsScene()
    lazy var store: ValuesStoring = makeCharacteristicsStore()
    
    init(container: DependencyContainer, parent: ValuesCoordinatorEventHandling) {
        self.container = container
        self.parent = parent
    }
}

// MARK: - Coordinator
extension ValuesCoordinator: ViewCoordinator {
    func start() {}
}

// MARK: - Factories
private extension ValuesCoordinator {
    func makeCharacteristicsScene() -> ValuesTab {
        ValuesTab(store: store)
    }
    
    func makeCharacteristicsStore() -> ValuesStore {
        ValuesStore(deviceManager: container[.deviceManager])
    }
}
