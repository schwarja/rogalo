//
//  CharacteristicGradientView.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import SwiftUI

struct ValueGradientView: View {
    let scale: ValueScale
    
    let colors: [Color]
    
    init(scale: ValueScale) {
        self.scale = scale
        
        switch scale.order {
        case .asceding:
            colors = [.green, .yellow, .red]
        case .descending:
            colors = [.red, .yellow, .green]
        }
    }
    
    var gradient: LinearGradient {
        let stop1 = Gradient.Stop(color: colors[0], location: 0)
        let stop2 = Gradient.Stop(color: colors[1], location: scale.midLocation)
        let stop3 = Gradient.Stop(color: colors[2], location: 1)

        let grad = Gradient(stops: [stop1, stop2, stop3])
        
        return LinearGradient(gradient: grad, startPoint: .leading, endPoint: .trailing)
    }
    
    var mask: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [.appBackground, Color.appBackground.opacity(0)]), startPoint: .top, endPoint: .bottom)
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
                    .fill(Color.appText.opacity(0.5))
                    .frame(width: width, height: height)
                    .offset(
                        x: xOffset,
                        y: yOffset)
            }
        }
    }
}

struct ValueGradientView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ValueGradientView(
                scale: ValueScale(
                    midLocation: 0.5,
                    progress: 0.7,
                    order: .asceding
                )
            )
            ValueGradientView(
                scale: ValueScale(
                    midLocation: 0.5,
                    progress: 1.5,
                    order: .descending
                )
            )
        }
    }
}
