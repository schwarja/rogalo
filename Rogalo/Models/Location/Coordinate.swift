//
//  Coordinate.swift
//  Rogalo
//
//  Created by Jan on 27.03.2021.
//

import CoreLocation

struct Coordinate {
    let latitude: Double
    let longitude: Double
    
    var clCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var clLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func distance(to coordinate: Coordinate) -> Double {
        self.clLocation.distance(from: coordinate.clLocation)
    }
}
