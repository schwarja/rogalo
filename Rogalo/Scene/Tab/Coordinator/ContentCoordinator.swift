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
    func handle(event: SettingsCoordinatorEvent) {
    }
}

// MARK: - Characteristics event handling
extension ContentCoordinator: CharacteristicsCoordinatorEventHandling {
    func handle(event: CharacteristicsCoordinatorEvent) {
    }
}

// MARK: - Factories
private extension ContentCoordinator {
    func makeContentScene() -> ContentView {
        let settings = makeSettingsScene()
        settings.start()
        
        let characteristics = makeCharacteristicsScene()
        characteristics.start()
        
        childCoordinators.append(settings)
        childCoordinators.append(characteristics)
        
        return ContentView(
            store: store,
            tabs: [
                .characteristics(view: characteristics.rootView),
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
    
    func makeCharacteristicsScene() -> CharacteristicsCoordinator {
        CharacteristicsCoordinator(container: container, parent: self)
    }
}
