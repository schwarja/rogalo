//
//  RecordsCoordinator.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Foundation

class RecordsCoordinator: Coordinator {
    let container: DependencyContainer
    var childCoordinators: [Coordinator]  = []
    weak var parent: RecordsCoordinatorEventHandling?
    
    lazy var rootView: RecordsTab = makeRecordsScene()
    lazy var store: RecordsStoring = makeRecordsStore()
    
    init(container: DependencyContainer, parent: RecordsCoordinatorEventHandling) {
        self.container = container
        self.parent = parent
    }
}

// MARK: - Coordinator
extension RecordsCoordinator: ViewCoordinator {
    func start() {}
}

// MARK: - Factories
private extension RecordsCoordinator {
    func makeRecordsScene() -> RecordsTab {
        RecordsTab(store: store)
    }
    
    func makeRecordsStore() -> RecordsStore {
        RecordsStore(deviceManager: container[.deviceManager])
    }
}
