//
//  MapRenderingCoordinator.swift
//  Rogalo
//
//  Created by Jan on 23.03.2021.
//

import Foundation
import MapKit

class MapRenderingCoordinator: NSObject, UIKitMapViewDelegate {
    private var parent: MapRenderingView

    init(_ parent: MapRenderingView) {
        self.parent = parent
    }
    
    func update(parent: MapRenderingView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        parent.recenter(view: mapView)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = parent.strokeWidth
        renderer.strokeColor = parent.strokeColor
        return renderer
    }
    
    func userDidInteractWithMapView(_ mapView: UIKitMapView) {
        parent.stickToCurrentLocation = false
    }
}
