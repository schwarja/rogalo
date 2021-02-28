//
//  RecordsTab.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Foundation

import SwiftUI

struct RecordsTab: View {
    let store: RecordsStoring
    
    @State var connectionState = Device.State.connecting
    @State var characteristics: [CharacteristicStoring] = []

    var body: some View {
        NavigationView {
            RecordsView(
                    connectionState: connectionState,
                    characteristics: characteristics
                )
                .navigationBarTitle("Records")
        }
        .onReceive(store.connectionState, perform: { self.connectionState = $0 })
        .onReceive(store.characteristics, perform: { self.characteristics = $0 })
    }
}

struct RecordsTab_Previews: PreviewProvider {
    static var previews: some View {
        RecordsTab(store: MockRecordsStore())
    }
}