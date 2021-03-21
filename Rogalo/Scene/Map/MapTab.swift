//
//  MapTab.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import SwiftUI

struct MapTab: View {
    let store: MapStoring
    weak var coordinator: MapTabEventHandling?

    @State var authorization: LocationAuthorization = .notDetermined
    @State var location: Location?

    init(store: MapStoring, coordinator: MapTabEventHandling?) {
        self.store = store
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationView {
            MapView(
                authorization: authorization,
                location: location,
                coordinator: coordinator
            )
            .navigationBarTitle(LocalizedString.mapTitle())
        }
        .onReceive(store.authorization, perform: { self.authorization = $0 })
        .onReceive(store.location, perform: { self.location = $0 })
    }
}

struct MapTab_Previews: PreviewProvider {
    static var previews: some View {
        MapTab(store: MockMapStore(), coordinator: nil)
    }
}
