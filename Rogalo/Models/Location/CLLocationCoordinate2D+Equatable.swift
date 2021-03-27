//
//  CLLocationCoordinate2D+Equatable.swift
//  Rogalo
//
//  Created by Jan on 27.03.2021.
//

import CoreLocation

func != (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    lhs.latitude != rhs.latitude || lhs.longitude != rhs.longitude
}

func != (lhs: CLLocationCoordinate2D?, rhs: CLLocationCoordinate2D?) -> Bool {
    guard let ulhs = lhs, let urhs = rhs else {
        return true
    }
    
    return ulhs.latitude != urhs.latitude || ulhs.longitude != urhs.longitude
}
