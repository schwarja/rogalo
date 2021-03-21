//
//  MapView.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import SwiftUI

struct MapView: View {
    let authorization: LocationAuthorization
    let location: Location?
    weak var coordinator: MapTabEventHandling?
    
    @State var stickToCurrentLocation = true

    var body: some View {
        VStack {
            if authorization != .authorized {
                StatusView(
                    model: authorization.statusViewModel,
                    eventHandler: coordinator
                )
            }
            HStack {
                ValueView(store: ValueStore(value: MapValue.altitude(altitude: location?.altitude)))
                    .frame(maxWidth: .infinity)
                ValueView(store: ValueStore(value: MapValue.speed(speed: location?.speed)))
                    .frame(maxWidth: .infinity)
            }
            ZStack(alignment: .bottomTrailing) {
                MapRenderingView(stickToCurrentLocation: $stickToCurrentLocation)
                Button(
                    action: {
                        stickToCurrentLocation = true
                    },
                    label: {
                        Image(systemName: "location.north.fill")
                            .padding()
                    }
                )
                .background(Color(white: 1, opacity: 0.3))
                .cornerRadius(8)
                .padding(24)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(authorization: .notDetermined, location: nil)
    }
}
