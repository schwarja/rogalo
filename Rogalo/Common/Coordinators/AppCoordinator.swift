//
//  AppCoordinator.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import UIKit

final class AppCoordinator {
    var childCoordinators = [Coordinator]()

    private(set) var activeSessions: [ActiveSceneSession] = []

    let container: DependencyContainer = AppDependency()
}

// MARK: - AppCoordinating

extension AppCoordinator: AppCoordinating {
    func start() {
        assembleDependencyInjectionContainer()
    }
}

// MARK: - Assembly

// Extension is internal to be accessible from test target
extension AppCoordinator {
    func assembleDependencyInjectionContainer() {
        let bluetooth = BluetoothManager()
        let notifications = NotificationManager()
        let storage = AppStorage(container: UserDefaults.standard)
        let settings = SettingsService(storage: storage)
        
        container.register(bluetooth, for: .bluetoothManager)
        container.register(storage, for: .storage)
        container.register(notifications, for: .notifications)
        container.register(settings, for: .settingsService)
        
        let deviceRetrieve: DeviceManagerRetriever = { peripheral -> DeviceManaging in
            DeviceManager(peripheral: peripheral, bluetoothManager: bluetooth, storage: storage, notificationManager: notifications)
        }
        container.register(deviceRetrieve, for: .deviceManagerRegistration)
    }
}

// MARK: Scenes management
extension AppCoordinator {
    func didLaunchScene<Coordinator: SceneCoordinating>(for session: UISceneSession, window: UIWindow) -> Coordinator {
        let coordinator: Coordinator = makeSceneCoordinator(with: window)

        activeSessions.append((session: session, coordinatorId: ObjectIdentifier(coordinator)))
        childCoordinators.append(coordinator)

        return coordinator
    }

    func didDisconnectScene(for session: UISceneSession) {
        removeSceneCoordinator(for: session)
    }

    func didDestroy(session: UISceneSession) {
        removeSceneCoordinator(for: session)

        if let index = activeSessions.firstIndex(where: { $0.session == session }) {
            activeSessions.remove(at: index)
        }
    }
}

// MARK: Coordinators management
private extension AppCoordinator {
    func makeSceneCoordinator<Coordinator: SceneCoordinating>(with window: UIWindow) -> Coordinator {
        let coordinator = Coordinator(window: window, container: container)

        return coordinator
    }

    func removeSceneCoordinator(for session: UISceneSession) {
        guard let index = activeSessions.firstIndex(where: { $0.session == session }) else {
            return
        }

        let coordinatorId = activeSessions[index].coordinatorId

        // Remove coordinator from child coordinators
        if let index = childCoordinators.firstIndex(where: { ObjectIdentifier($0) == coordinatorId }) {
            childCoordinators.remove(at: index)
        }

        // Unregister the coordinator from the active session
        activeSessions[index].coordinatorId = nil
    }
}
