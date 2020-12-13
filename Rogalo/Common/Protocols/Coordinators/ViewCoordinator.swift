//
//  ViewCoordinating.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import SwiftUI

protocol ViewCoordinator: Coordinator, ParentCoordinatorContaining {
    associatedtype RootView: View
    
    var rootView: RootView { get }
}
