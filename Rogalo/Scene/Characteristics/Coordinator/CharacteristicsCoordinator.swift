//
//  CharacteristicsCoordinator.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

class CharacteristicsCoordinator: Coordinator {
    let container: DependencyContainer
    var childCoordinators: [Coordinator]  = []
    weak var parent: CharacteristicsCoordinatorEventHandling?
    
    lazy var rootView: CharacteristicsTab = makeCharacteristicsScene()
    lazy var store: EngineStore = makeCharacteristicsStore()
    
    init(container: DependencyContainer, parent: CharacteristicsCoordinatorEventHandling) {
        self.container = container
        self.parent = parent
    }
}

// MARK: - Coordinator
extension CharacteristicsCoordinator: ViewCoordinator {
    func start() {}
}

// MARK: - Factories
private extension CharacteristicsCoordinator {
    func makeCharacteristicsScene() -> CharacteristicsTab {
        CharacteristicsTab(store: store)
    }
    
    func makeCharacteristicsStore() -> EngineStore {
        EngineStore(deviceManager: container[.deviceManager])
    }
}
