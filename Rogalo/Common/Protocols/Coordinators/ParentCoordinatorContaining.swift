//
//  ParentCoordinatorContaining.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Foundation

protocol ParentCoordinatorContaining: AnyObject {
    associatedtype ParentCoordinator

    var parent: ParentCoordinator? { get set }
}
