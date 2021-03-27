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
    
    private var zoomUpdateThrottler: Timer?

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
        switch overlay {
        case is MKTrackLine:
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.lineWidth = parent.strokeWidth
            renderer.strokeColor = parent.strokeColorTrack
            return renderer
        case is MKRoutePolyline:
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.lineWidth = parent.strokeWidth
            renderer.strokeColor = parent.strokeColorRoute
            return renderer
        default:
            return MKOverlayRenderer()
        }
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        zoomUpdateThrottler?.invalidate()
        
        zoomUpdateThrottler = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
            self?.parent.updateZoom(to: mapView.region.span)
        }
    }
    
    func userDidInteractWithMapView(_ mapView: UIKitMapView) {
        parent.stickToCurrentLocation = false
    }
    
    func userDidDropPin(at coordinate: CLLocationCoordinate2D, in mapView: UIKitMapView) {
        parent.pinCoordinate = Coordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}
