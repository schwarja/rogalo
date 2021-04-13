//
//  MapTypePickerView.swift
//  Rogalo
//
//  Created by Jan on 13.04.2021.
//

import SwiftUI

struct MapTypePickerView: View {
    @Binding var mapType: MapRenderingView.MapType

    var body: some View {
        Picker("", selection: $mapType) {
            ForEach(MapRenderingView.MapType.allCases) { type in
                AppText(type.title, style: .caption)
                    .tag(type)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct MapTypePickerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MapTypePickerView(mapType: .constant(.default))
            
            MapTypePickerView(mapType: .constant(.satelite))
                .preferredColorScheme(.dark)
        }
    }
}
