//
//  CharacteristicsView.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import SwiftUI

struct CharacteristicsView: View {
    let engine: Device
    
    var body: some View {
        VStack {
            Text(String(describing: engine.state))
            
            Spacer()
            
            HStack {
                Text("Engine speed: ")
                if let value = engine.speed {
                    Text(value.description)
                } else {
                    Text("undefined")
                }
            }.padding(8)
            
            HStack {
                Text("Engine speed MAX: ")
                if let value = engine.speedMax {
                    Text(value.description)
                } else {
                    Text("undefined")
                }
            }.padding(8)
            
            HStack {
                Text("Voltage: ")
                if let value = engine.voltage {
                    Text(value.description)
                } else {
                    Text("undefined")
                }
            }.padding(8)
            
            HStack {
                Text("Flight time: ")
                if let value = engine.flightTime {
                    Text(value.description)
                } else {
                    Text("undefined")
                }
            }.padding(8)
            
            HStack {
                Text("Moto time: ")
                if let value = engine.motoTime {
                    Text(value.description)
                } else {
                    Text("undefined")
                }
            }.padding(8)
            
            HStack {
                Text("Temperature: ")
                if let value = engine.temperature {
                    Text(value.description)
                } else {
                    Text("undefined")
                }
            }.padding(8)
            
            HStack {
                Text("Temperature MAX: ")
                if let value = engine.temperatureMax {
                    Text(value.description)
                } else {
                    Text("undefined")
                }
            }.padding(8)
        }
    }
}

struct CharacteristicsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacteristicsView(engine: .mock)
    }
}
