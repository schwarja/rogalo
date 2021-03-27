//
//  MapDestinationView.swift
//  Rogalo
//
//  Created by Jan on 27.03.2021.
//

import SwiftUI

struct MapDestinationView: View {
    let distance: Double
    let cancelHandler: () -> Void
    
    var body: some View {
        HStack {
            AppText(
                "\(LocalizedString.mapDistanceToDestinationTitle()): \(Formatters.formattedDistance(for: distance))",
                style: .body
            )
            .padding(.leading, 8)
            
            Spacer(minLength: 16)
            
            AppButton(
                LocalizedString.generalActionCancel(),
                style: .action,
                action: cancelHandler
            )
        }
    }
}

struct MapDestinationView_Previews: PreviewProvider {
    static var previews: some View {
        MapDestinationView(distance: 500, cancelHandler: { })
    }
}
