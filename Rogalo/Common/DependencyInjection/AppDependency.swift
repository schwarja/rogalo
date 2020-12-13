//
//  AppDependency.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Foundation

class AppDependency: DependencyContainer {
    private var dependencies = [DependencyType: Any]()
    
    init() {}
    
    func register(_ dependency: Any, for type: DependencyType) {
        dependencies[type] = dependency
    }
    
    func resolve<T>(type: DependencyType) -> T {
        dependencies[type] as! T
    }
    
    func unregister(type: DependencyType) {
        dependencies[type] = nil
    }
}
