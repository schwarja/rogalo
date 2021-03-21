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
            MapRenderingView()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(authorization: .notDetermined, location: nil)
    }
}
