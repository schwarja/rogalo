//
//  LocationManager.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import CoreLocation
import Combine

final class LocationManager: NSObject {
    static let distanceFilter: CLLocationDistance = 10
    static let horizontalAccuracyFilter: CLLocationDistance = 50

    // swiftlint:disable:next implicitly_unwrapped_optional
    private var locationManager: CLLocationManager!
    private var authorizationStatus: CLAuthorizationStatus {
        if #available(iOS 14.0, *) {
            return locationManager.authorizationStatus
        } else {
            return CLLocationManager.authorizationStatus()
        }
    }
    private var isLocationPrecise: Bool {
        if #available(iOS 14.0, *) {
            let accuracy = locationManager.accuracyAuthorization
            switch accuracy {
            case .fullAccuracy:
                return true
            default:
                return false
            }
        } else {
            return true
        }
    }

    private let locationSubject = PassthroughSubject<Location, Never>()
    private let errorSubject = PassthroughSubject<Error, Never>()
    private let authorizationSubject = CurrentValueSubject<LocationAuthorization, Never>(.notDetermined)

    override public init() {
        super.init()

        // DispatchQueue.main.async is here to make sure that location manager is
        // initialized on main thread. Using LocationManager in Widget caused
        // the init to be executed on background thread.
        DispatchQueue.main.async {
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            self.locationManager.distanceFilter = LocationManager.distanceFilter
        }
    }
}

// MARK: - LocationManaging
extension LocationManager: LocationManaging {
    var location: AnyPublisher<Location, Never> {
        locationSubject
            .throttle(for: .seconds(0.5), scheduler: RunLoop.main, latest: true)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    var error: AnyPublisher<Error, Never> {
        errorSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    var authorization: AnyPublisher<LocationAuthorization, Never> {
        authorizationSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - Refresh
extension LocationManager {
    func refreshLocation() {
        DispatchQueue.main.async {
            self.locationManager.stopUpdatingLocation()
            self.locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - Authorization
extension LocationManager {
    func requestAuthorization() {
        DispatchQueue.main.async {
            self.handleAuthorizationStatus()
        }
    }
}

// MARK: - Private methods
private extension LocationManager {
    func handleAuthorizationStatus() {
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            if isLocationPrecise {
                authorizationSubject.send(.authorized)
            } else {
                authorizationSubject.send(.authorizedNotPrecise)
            }
        case .restricted, .denied:
            authorizationSubject.send(.denied)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            authorizationSubject.send(.denied)
        }
    }
}

// MARK: - CLLocationManagerDelegate methods
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, location.horizontalAccuracy >= Self.horizontalAccuracyFilter else {
            return
        }

        let receivedLocation = Location(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            speed: location.speed,
            altitude: location.altitude
        )

        locationSubject.send(receivedLocation)
    }

    func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        let error = error as NSError

        // Apple docs say:
        // If the location service is unable to retrieve a location right away, it reports a CLError.Code.locationUnknown error and keeps trying.
        // In such a situation, you can simply ignore the error and wait for a new event.
        // More info at: https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate/1423786-locationmanager
        if error.domain == kCLErrorDomain, error.code == CLError.Code.locationUnknown.rawValue {
            return
        }

        errorSubject.send(error)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleAuthorizationStatus()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleAuthorizationStatus()
    }
}
