//
//  MapControlsView.swift
//  Rogalo
//
//  Created by Jan on 27.03.2021.
//

import SwiftUI

struct MapControlsView: View {
    static let backgroundOpacity = 0.3
    static let cornerRadius: CGFloat = 8
    
    @Binding var stickToCurrentLocation: Bool
    @Binding var zoomDiameter: Double
    var zoomRange: ClosedRange<Double>
    
    var body: some View {
        HStack {
            ZoomSliderView(zoomDiameter: $zoomDiameter, range: zoomRange)
                .padding(10)
                .background(Color.appBackgroundInverted.opacity(Self.backgroundOpacity))
                .cornerRadius(Self.cornerRadius)
            
            Spacer(minLength: 16)
            
            Button(
                action: {
                    stickToCurrentLocation = true
                },
                label: {
                    Image(systemName: "location.north.fill")
                        .padding()
                }
            )
            .background(Color.appBackgroundInverted.opacity(Self.backgroundOpacity))
            .cornerRadius(Self.cornerRadius)
        }
        .padding(24)
    }
}

struct MapControlsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MapControlsView(
                stickToCurrentLocation: .constant(true),
                zoomDiameter: .constant(200),
                zoomRange: 0...400
            )

            MapControlsView(
                stickToCurrentLocation: .constant(true),
                zoomDiameter: .constant(200),
                zoomRange: 0...400
            )
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
