//
//  MapView.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import SwiftUI

struct MapView: View {
    static let zoomRange: ClosedRange<Double> = 0.001...0.1
    
    let store: MapStoring
    weak var coordinator: MapTabEventHandling?

    @State var authorization: LocationAuthorization = .notDetermined
    @State var currentLocation: Location?
    @State var locations: [Location] = []
    @State var stickToCurrentLocation = true
    @State var zoomDiameter: Double = 0.004
    @State var track: (start: Coordinate, end: Coordinate)?

    var body: some View {
        VStack {
            if authorization != .authorized && authorization != .notDetermined {
                StatusView(
                    model: authorization.statusViewModel,
                    eventHandler: coordinator
                )
            }
            Group {
                if let destination = track?.end, let current = currentLocation {
                    MapDestinationView(distance: current.coordinate.distance(to: destination)) {
                        track = nil
                    }
                    .frame(minHeight: 56)
                } else {
                    AppText(LocalizedString.mapNoDestinationTitle(), style: .body)
                        .frame(minHeight: 56)
                }
            }
                .padding(.horizontal, 8)
            HStack {
                ValueView(store: ValueStore(value: MapValue.altitude(altitude: currentLocation?.altitude)))
                    .frame(maxWidth: .infinity)
                ValueView(store: ValueStore(value: MapValue.speed(speed: currentLocation?.speed)))
                    .frame(maxWidth: .infinity)
            }
            ZStack(alignment: .bottom) {
                mapView
                mapControls
            }
        }
        .onReceive(store.authorization, perform: { self.authorization = $0 })
        .onReceive(store.currentLocation, perform: { self.currentLocation = $0 })
        .onReceive(store.locations, perform: { self.locations = $0 })
    }
    
    var mapView: MapRenderingView {
        MapRenderingView(
            track: $track,
            stickToCurrentLocation: $stickToCurrentLocation,
            zoomRange: $zoomDiameter,
            locations: $locations
        )
    }
    
    var mapControls: MapControlsView {
        MapControlsView(
            stickToCurrentLocation: $stickToCurrentLocation,
            zoomDiameter: $zoomDiameter,
            zoomRange: Self.zoomRange
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(store: MockMapStore())
    }
}
