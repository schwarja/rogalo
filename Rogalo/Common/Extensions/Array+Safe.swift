//
//  Array+Safe.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        guard index.distance(to: self.count) >= 0 else {
            return nil
        }
        
        return self[index]
    }
}
