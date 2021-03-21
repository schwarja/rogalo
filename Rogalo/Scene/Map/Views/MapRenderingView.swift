//
//  MKMapView.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import SwiftUI
import MapKit

struct MapRenderingView: UIViewRepresentable {
    @Binding var stickToCurrentLocation: Bool
    
    func makeUIView(context: Context) -> UIKitMapView {
        let mapView = UIKitMapView()
        mapView.interactionDelegate = context.coordinator
        mapView.showsUserLocation = true
        return mapView
    }

    func updateUIView(_ view: UIKitMapView, context: Context) {
        context.coordinator.recenter(view)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIKitMapViewDelegate {
        var parent: MapRenderingView

        init(_ parent: MapRenderingView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            recenter(mapView)
        }
        
        func userDidInteractWithMapView(_ mapView: UIKitMapView) {
            parent.stickToCurrentLocation = false
        }
        
        func recenter(_ mapView: MKMapView) {
            guard parent.stickToCurrentLocation else {
                return
            }
            
            let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 400, longitudinalMeters: 400)

            mapView.setRegion(region, animated: true)
        }
    }
}
