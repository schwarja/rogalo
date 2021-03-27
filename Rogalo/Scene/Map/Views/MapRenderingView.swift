//
//  MKMapView.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import SwiftUI
import MapKit

struct MapRenderingView: UIViewRepresentable {
    let strokeWidth: CGFloat = 5
    let strokeColor: UIColor = .red
    
    @Binding var stickToCurrentLocation: Bool
    @Binding var zoomRange: Double
    var locations: [Location]
    
    private let span = CoordinateSpan()
    
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
        zoom(in: view)
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
        
        let span = MKCoordinateSpan(latitudeDelta: zoomRange, longitudeDelta: zoomRange)
        let region = MKCoordinateRegion(center: view.userLocation.coordinate, span: span)
        
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
    
    private func zoom(in view: MKMapView) {
        guard span.latitude != zoomRange else {
            return
        }
                
        let span = MKCoordinateSpan(latitudeDelta: zoomRange, longitudeDelta: zoomRange)
        let region = MKCoordinateRegion(center: view.centerCoordinate, span: span)

        self.span.update(with: span)
        view.setRegion(region, animated: true)
    }
    
    func updateZoom(to span: MKCoordinateSpan) {
        guard abs(self.span.latitude - span.latitudeDelta) > (0.1*self.span.latitude) else {
            return
        }

        self.span.update(with: span)
        zoomRange = span.latitudeDelta
    }
}
