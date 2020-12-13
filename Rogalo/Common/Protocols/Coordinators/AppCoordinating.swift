//
//  AppCoordinating.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import UIKit

protocol AppCoordinating: Coordinator {
    func didLaunchScene<Coordinator: SceneCoordinating>(for session: UISceneSession, window: UIWindow) -> Coordinator

    func didDisconnectScene(for session: UISceneSession)

    func didDestroy(session: UISceneSession)
}
