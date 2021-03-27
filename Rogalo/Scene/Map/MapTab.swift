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

    init(store: MapStoring, coordinator: MapTabEventHandling?) {
        self.store = store
        self.coordinator = coordinator
    }

    var body: some View {
        MapView(
            store: store,
            coordinator: coordinator
        )
    }
}

struct MapTab_Previews: PreviewProvider {
    static var previews: some View {
        MapTab(store: MockMapStore(), coordinator: nil)
    }
}
