//
//  AppDelegate.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, AppCoordinatorContaining {
    // swiftlint:disable:next implicitly_unwrapped_optional
    private(set) var coordinator: AppCoordinating!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setup()
        applyAppearance()
        
        return true
    }
}

private extension AppDelegate {
    func setup() {
        coordinator = AppCoordinator()
        coordinator.start()
    }
    
    func applyAppearance() {
        // swiftlint:disable force_unwrapping
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font: AppTextStyle.navigationTitleLarge.uiFont!,
            .foregroundColor: R.color.textColor()!
        ]
        UINavigationBar.appearance().titleTextAttributes = [
            .font: AppTextStyle.navigationTitle.uiFont!,
            .foregroundColor: R.color.textColor()!
        ]
        // swiftlint:enable force_unwrapping
    }
}

// MARK: UISceneSession Lifecycle
extension AppDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
