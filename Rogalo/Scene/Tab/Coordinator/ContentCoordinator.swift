//
//  ContentCoordinator.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

class ContentCoordinator: Coordinator {
    let container: DependencyContainer
    var childCoordinators: [Coordinator]  = []
    weak var parent: ContentCoordinatorEventHandling?
    
    lazy var rootView: ContentView = makeContentScene()
    lazy var store: ContentStore = makeContentStore()
    
    init(container: DependencyContainer, parent: ContentCoordinatorEventHandling) {
        self.container = container
        self.parent = parent
    }
}

// MARK: - Coordinator
extension ContentCoordinator: ViewCoordinator {
    func start() {}
}

// MARK: - Settings event handling
extension ContentCoordinator: SettingsCoordinatorEventHandling {
    func handle(event: SettingsCoordinatorEvent) {}
}

// MARK: - Characteristics event handling
extension ContentCoordinator: ValuesCoordinatorEventHandling {
    func handle(event: ValuesCoordinatorEvent) {}
}

// MARK: - Records event handling
extension ContentCoordinator: RecordsCoordinatorEventHandling {
    func handle(event: RecordsCoordinatorEvent) {}
}

// MARK: - Records event handling
extension ContentCoordinator: MapCoordinatorEventHandling {
    func handle(event: MapCoordinatorEvent) {}
}

// MARK: - Factories
private extension ContentCoordinator {
    func makeContentScene() -> ContentView {
        let settings = makeSettingsScene()
        settings.start()
        
        let characteristics = makeCharacteristicsScene()
        characteristics.start()
        
        let map = makeMapScene()
        map.start()
        
        let records = makeRecordsScene()
        records.start()
        
        childCoordinators.append(settings)
        childCoordinators.append(characteristics)
        childCoordinators.append(map)
        childCoordinators.append(records)
        
        return ContentView(
            store: store,
            tabs: [
                .characteristics(view: characteristics.rootView),
                .records(view: records.rootView),
                .map(view: map.rootView),
                .settings(view: settings.rootView)
            ]
        )
    }
    
    func makeContentStore() -> ContentStore {
        return ContentStore(deviceManager: container[.deviceManager])
    }
    
    func makeSettingsScene() -> SettingsCoordinator {
        SettingsCoordinator(container: container, parent: self)
    }
    
    func makeCharacteristicsScene() -> ValuesCoordinator {
        ValuesCoordinator(container: container, parent: self)
    }
    
    func makeRecordsScene() -> RecordsCoordinator {
        RecordsCoordinator(container: container, parent: self)
    }
    
    func makeMapScene() -> MapCoordinator {
        MapCoordinator(container: container, parent: self)
    }
}
