//
//  UIKitMapView.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import SwiftUI
import MapKit

protocol UIKitMapViewDelegate: MKMapViewDelegate {
    func userDidInteractWithMapView(_ mapView: UIKitMapView)
}

class UIKitMapView: MKMapView {
    weak var interactionDelegate: UIKitMapViewDelegate? {
        didSet {
            delegate = interactionDelegate
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        interactionDelegate?.userDidInteractWithMapView(self)
    }
}
