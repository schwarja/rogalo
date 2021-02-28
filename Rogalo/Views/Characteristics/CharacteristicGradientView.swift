//
//  CharacteristicGradientView.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import SwiftUI

struct CharacteristicGradientView: View {
    let scale: CharacteristicScale
    
    var colors: Gradient {
        let stop1 = Gradient.Stop(color: .green, location: 0)
        let stop2 = Gradient.Stop(color: .yellow, location: scale.midLocation)
        let stop3 = Gradient.Stop(color: .red, location: 1)

        return Gradient(stops: [stop1, stop2, stop3])
    }
    
    var gradient: LinearGradient {
        LinearGradient(gradient: colors, startPoint: .leading, endPoint: .trailing)
    }
    
    var mask: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [.white, Color.white.opacity(0)]), startPoint: .top, endPoint: .bottom)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let height = geometry.size.height/3
                let width: CGFloat = 16
                
                let normalizedProgress = (scale.progress-0.5)*2
                let xOffset = ((geometry.size.width-width)/2)*normalizedProgress
                let yOffset = geometry.size.height/2-height/2
                
                Rectangle()
                    .fill(gradient)
                    .opacity(0.9)
                
                Rectangle()
                    .fill(mask)
                
                Triangle()
                    .fill(Color.black.opacity(0.5))
                    .frame(width: width, height: height)
                    .offset(
                        x: xOffset,
                        y: yOffset)
            }
        }
    }
}

struct CharacteristicGradientView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CharacteristicGradientView(
                scale: CharacteristicScale(
                    midLocation: 0.5,
                    progress: 0.7
                )
            )
            CharacteristicGradientView(
                scale: CharacteristicScale(
                    midLocation: 0.5,
                    progress: 1
                )
            )
        }
    }
}
