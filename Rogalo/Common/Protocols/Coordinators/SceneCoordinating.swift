//
//  SceneCoordinating.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import UIKit

protocol SceneCoordinating: Coordinator {
    init(window: UIWindow, container: DependencyContainer)
}
