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
    func userDidDropPin(at coordinate: CLLocationCoordinate2D, in mapView: UIKitMapView)
}

class UIKitMapView: MKMapView {
    weak var interactionDelegate: UIKitMapViewDelegate? {
        didSet {
            delegate = interactionDelegate
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        interactionDelegate?.userDidInteractWithMapView(self)
    }
}

// MARK: Private methods
private extension UIKitMapView {
    func setup() {
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(self.didLongPress(_:)))
        longpress.minimumPressDuration = 1
        self.addGestureRecognizer(longpress)
    }
    
    @objc func didLongPress(_ recognizer: UILongPressGestureRecognizer) {
        guard recognizer.state == .began else {
            return
        }
        
        let point = recognizer.location(in: self)
        let coordinate = self.convert(point, toCoordinateFrom: self)
        
        interactionDelegate?.userDidDropPin(at: coordinate, in: self)
    }
}
