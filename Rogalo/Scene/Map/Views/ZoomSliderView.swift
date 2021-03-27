//
//  ZoomSliderView.swift
//  Rogalo
//
//  Created by Jan on 27.03.2021.
//

import SwiftUI

struct ZoomSliderView: View {
    @Binding var zoomDiameter: Double
    var range: ClosedRange<Double>
    
    var body: some View {
        Slider(value: $zoomDiameter, in: range)
            .accentColor(.appBackground)
    }
}

struct ZoomSliderView_Previews: PreviewProvider {
    static var value: Double = 200
    
    static var previews: some View {
        ZoomSliderView(
            zoomDiameter: Binding(get: { Self.value }, set: { newValue in
                    Self.value = newValue
                }
            ),
            range: 0...400)
    }
}
