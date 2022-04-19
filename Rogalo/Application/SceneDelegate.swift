//
//  SceneDelegate.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private weak var coordinator: SceneCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        setupInitialScene(with: windowScene, session: session)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        appCoordinator.didDisconnectScene(for: session)
    }
}

// MARK: - Setup
private extension SceneDelegate {
    var appCoordinator: AppCoordinating {
        guard let delegate = UIApplication.shared.delegate as? AppCoordinatorContaining else {
            fatalError("Application delegate doesn't implement `AppCoordinatorContaining` protocol")
        }

        return delegate.coordinator
    }
    
    var session: UISceneSession {
        guard let session = window?.windowScene?.session else {
            fatalError("Scene delegate not connected to any session \(self)")
        }

        return session
    }

    func setupInitialScene(with windowScene: UIWindowScene, session: UISceneSession) {
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        coordinator = appCoordinator.didLaunchScene(for: session, window: window)

        coordinator?.start()
    }
}
