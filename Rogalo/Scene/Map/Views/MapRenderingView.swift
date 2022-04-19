//
//  MKMapView.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import SwiftUI
import MapKit

struct MapRenderingView: UIViewRepresentable {
    enum MapType: String, CaseIterable, Identifiable {
        case `default`
        case satelite
        
        var id: String {
            rawValue
        }
        
        var title: String {
            switch self {
            case .default:
                return LocalizedString.mapTypeDefault()
            case .satelite:
                return LocalizedString.mapTypeSatelite()
            }
        }
        
        var mkType: MKMapType {
            switch self {
            case .default:
                return .standard
            case .satelite:
                return .satellite
            }
        }
    }
    
    let strokeWidth: CGFloat = 5
    // swiftlint:disable:next force_unwrapping
    let strokeColorRoute: UIColor = R.color.failureIndicationColor()!
    // swiftlint:disable:next force_unwrapping
    let strokeColorTrack: UIColor = R.color.tintColor()!

    @Binding var track: (start: Coordinate, end: Coordinate)?
    @Binding var stickToCurrentLocation: Bool
    @Binding var zoomRange: Double
    @Binding var locations: [Location]
    @Binding var type: MapType
    
    func makeUIView(context: Context) -> UIKitMapView {
        let mapView = UIKitMapView()
        mapView.interactionDelegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.mapType = type.mkType
        
        addPath(to: mapView)
        dropPin(in: mapView)
        
        return mapView
    }

    func updateUIView(_ view: UIKitMapView, context: Context) {
        context.coordinator.update(parent: self)

        updateMapType(for: view)
        updateRegion(in: view)
        addPath(to: view)
        dropPin(in: view)
        updateDirection(in: view)
    }

    func makeCoordinator() -> MapRenderingCoordinator {
        MapRenderingCoordinator(self)
    }
}

extension MapRenderingView {
    func updateRegion(in view: MKMapView) {
        let center = stickToCurrentLocation ? view.userLocation.coordinate : view.centerCoordinate
        
        guard view.region.span.longitudeDelta != zoomRange || view.region.center != center else {
            return
        }
        
        let span = MKCoordinateSpan(latitudeDelta: zoomRange, longitudeDelta: zoomRange)
        let region = MKCoordinateRegion(center: center, span: span)
        
        view.setRegion(region, animated: false)
    }
    
    func updateDirection(in view: MKMapView) {
        guard locations.count > 1 else {
            return
        }
        
        let currentLocation = locations[locations.count-1]
        let previousLocation = locations[locations.count-2]
        
        let course = (currentLocation.course+previousLocation.course)/2
        
        view.camera.heading = course
    }

    private func addPath(to view: MKMapView) {
        let routeOverlays = view.overlays.filter { $0 is MKRoutePolyline }
        let trackOverlays = view.overlays.compactMap { $0 as? MKTrackLine }
        
        view.removeOverlays(routeOverlays)
        
        let coordinates = locations.map {
            CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
        }
        
        let route = MKRoutePolyline(coordinates: coordinates, count: coordinates.count)
        view.addOverlay(route)
        
        guard let track = track else {
            view.removeOverlays(trackOverlays)
            return
        }
        
        let trackCoordinates = [
            track.start.clCoordinate,
            track.end.clCoordinate
        ]
        let trackOverlay = MKTrackLine(coordinates: trackCoordinates, count: trackCoordinates.count)

        guard trackOverlay.coordinate != trackOverlays.first?.coordinate else {
            return
        }
        
        view.removeOverlays(trackOverlays)
        view.addOverlay(trackOverlay)
    }
    
    func updateZoom(to span: MKCoordinateSpan) {
        guard !stickToCurrentLocation && zoomRange != span.longitudeDelta else {
            return
        }
        
        zoomRange = span.longitudeDelta
    }
    
    func dropPin(in view: MKMapView) {
        let destinationCoordinate = track?.end.clCoordinate
        let annotationCoordinate = view.annotations.first?.coordinate
        
        guard destinationCoordinate != annotationCoordinate else {
            return
        }
        
        view.removeAnnotations(view.annotations)

        guard let coordinate = destinationCoordinate else {
            return
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        view.addAnnotation(annotation)
    }
    
    private func updateMapType(for view: MKMapView) {
        guard view.mapType != type.mkType else {
            return
        }
        
        view.mapType = type.mkType
    }
}
