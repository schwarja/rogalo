//
//  MapView.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import SwiftUI

struct MapView: View {
    let store: MapStoring
    weak var coordinator: MapTabEventHandling?

    @State var authorization: LocationAuthorization = .notDetermined
    @State var currentLocation: Location?
    @State var locations: [Location] = []
    @State var stickToCurrentLocation = true

    var body: some View {
        VStack {
            if authorization != .authorized && authorization != .notDetermined {
                StatusView(
                    model: authorization.statusViewModel,
                    eventHandler: coordinator
                )
            }
            HStack {
                ValueView(store: ValueStore(value: MapValue.altitude(altitude: currentLocation?.altitude)))
                    .frame(maxWidth: .infinity)
                ValueView(store: ValueStore(value: MapValue.speed(speed: currentLocation?.speed)))
                    .frame(maxWidth: .infinity)
            }
            ZStack(alignment: .bottomTrailing) {
                MapRenderingView(stickToCurrentLocation: $stickToCurrentLocation, locations: locations)
                Button(
                    action: {
                        stickToCurrentLocation = true
                    },
                    label: {
                        Image(systemName: "location.north.fill")
                            .padding()
                    }
                )
                .background(Color.appBackgroundInverted.opacity(0.3))
                .cornerRadius(8)
                .padding(24)
            }
        }
        .onReceive(store.authorization, perform: { self.authorization = $0 })
        .onReceive(store.currentLocation, perform: { self.currentLocation = $0 })
        .onReceive(store.locations, perform: { self.locations = $0 })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(store: MockMapStore())
    }
}
