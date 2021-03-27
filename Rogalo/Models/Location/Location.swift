//
//  Location.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import Foundation

struct Location {
    let coordinate: Coordinate
    let speed: Double
    let altitude: Double
    
    var latitude: Double {
        coordinate.latitude
    }
    var longitude: Double {
        coordinate.longitude
    }

    init(latitude: Double, longitude: Double, speed: Double, altitude: Double) {
        self.coordinate = Coordinate(latitude: latitude, longitude: longitude)
        self.speed = speed
        self.altitude = altitude
    }
}
