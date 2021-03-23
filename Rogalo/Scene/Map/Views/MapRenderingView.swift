//
//  MKMapView.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import SwiftUI
import MapKit

struct MapRenderingView: UIViewRepresentable {
    static let focusRange: CLLocationDistance = 400
    
    let strokeWidth: CGFloat = 5
    let strokeColor: UIColor = .red
    
    @Binding var stickToCurrentLocation: Bool
    var locations: [Location]
    
    func makeUIView(context: Context) -> UIKitMapView {
        let mapView = UIKitMapView()
        mapView.interactionDelegate = context.coordinator
        mapView.showsUserLocation = true
        
        addPath(to: mapView)
        
        return mapView
    }

    func updateUIView(_ view: UIKitMapView, context: Context) {
        context.coordinator.update(parent: self)
        
        recenter(view: view)
        addPath(to: view)
    }

    func makeCoordinator() -> MapRenderingCoordinator {
        MapRenderingCoordinator(self)
    }
}

extension MapRenderingView {
    func recenter(view: MKMapView) {
        guard stickToCurrentLocation else {
            return
        }
        
        let region = MKCoordinateRegion(center: view.userLocation.coordinate, latitudinalMeters: Self.focusRange, longitudinalMeters: Self.focusRange)

        view.setRegion(region, animated: true)
    }
    
    private func addPath(to view: MKMapView) {
        view.removeOverlays(view.overlays)
        
        let coordinates = locations.map {
            CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
        }
        let route = MKPolyline(coordinates: coordinates, count: coordinates.count)
        view.addOverlay(route)
    }
}
