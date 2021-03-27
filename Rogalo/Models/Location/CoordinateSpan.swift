//
//  CoordinateSpan.swift
//  Rogalo
//
//  Created by Jan on 27.03.2021.
//

import MapKit

class CoordinateSpan {
    var latitude: CLLocationDegrees = 0
    var longitude: CLLocationDegrees = 0
    
    func update(with span: MKCoordinateSpan) {
        self.latitude = span.latitudeDelta
        self.longitude = span.longitudeDelta
    }
}
