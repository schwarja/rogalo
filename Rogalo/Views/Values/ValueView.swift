//
//  CharacteristicView.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import SwiftUI

struct ValueView: View {
    let store: ValueStoring
    
    var body: some View {
        return ZStack {
            if let scale = store.scale {
                ValueGradientView(scale: scale)
            }
            
            VStack {
                AppText(store.valueDescription, style: .headline)
                    .padding([.top, .horizontal], 4)
                    .minimumScaleFactor(0.5)
                
                let valueText = Text(store.formattedValue)
                    .font(AppTextStyle.value.font)
                    .padding([.bottom, .horizontal], 4)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                
                if store.scale?.isCritical ?? false {
                    valueText
                        .foregroundColor(.appFailure)
                } else {
                    valueText
                        .foregroundColor(AppTextStyle.value.color)
                }
            }
        }
    }
}

struct CharacteristicView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ValueView(store: DeviceValueStore(value: .rpm(value: 8000))
            )
            ValueView(store: DeviceValueStore(value: .flightTime(value: 4))
            )
            ValueView(store: DeviceValueStore(value: .flightTime(value: 65))
            )
            ValueView(store: DeviceValueStore(value: .flightTime(value: 4836))
            )
            ValueView(store: DeviceValueStore(value: .temperatureEngine(value: 11.3))
            )
            ValueView(store: DeviceValueStore(value: .voltage(value: 11.3))
            )
            ValueView(store: ValueStore(value: MapValue.speed(speed: 14.8))
            )
            ValueView(store: ValueStore(value: MapValue.altitude(altitude: 348.2))
            )
        }
    }
}
