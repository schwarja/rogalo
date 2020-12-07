//
//  CharacteristicsView.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import SwiftUI

struct CharacteristicsView: View {
    @ObservedObject var store: EngineStore
    
    var body: some View {
        if let engine = store.engine {
            VStack {
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
        } else {
            Text("Pairing")
        }
    }
}

struct CharacteristicsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacteristicsView(store:
                                EngineStore(
                                    bluetoothManager: BluetoothManager()
                                )
        )
    }
}
