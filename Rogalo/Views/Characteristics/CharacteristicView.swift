//
//  CharacteristicView.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import SwiftUI

struct CharacteristicView: View {
    let store: CharacteristicStoring
    
    var body: some View {
        return ZStack {
            if let scale = store.scale {
                CharacteristicGradientView(scale: scale)
            }
            
            VStack {
                AppText(store.valueDescription, style: .headline)
                    .padding(4)
                    .minimumScaleFactor(0.5)
                
                AppText(store.formattedValue, style: .value)
                    .padding(8)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                }
            }
    }
}

struct CharacteristicView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CharacteristicView(store: CharacteristicStore(value: .rpm(value: 8000))
            )
            CharacteristicView(store: CharacteristicStore(value: .flightTime(value: 4))
            )
            CharacteristicView(store: CharacteristicStore(value: .flightTime(value: 65))
            )
            CharacteristicView(store: CharacteristicStore(value: .flightTime(value: 4836))
            )
        }
    }
}
