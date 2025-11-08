//
//  LocationManager.swift
//  countryDataFinder
//
//  Created by Esraa Eldaltony on 08/11/2025.
//
import Foundation
internal import Combine
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate,
    ObservableObject
{

    @Published var lastKnownLocation: CLLocation?
    @Published var countryName: String?
    @Published var needLocationPermission: Bool?
    var manager = CLLocationManager()

    func checkLocationAuthorization() {

        manager.delegate = self
        manager.startUpdatingLocation()

        switch manager.authorizationStatus {
        case .notDetermined:  //The user choose allow or denny your app to get the location yet
            manager.requestWhenInUseAuthorization()

        case .restricted:  //The user cannot change this app’s status, possibly due to active restrictions such as parental controls being in place.
            print("Location restricted")

        case .denied:  //The user dennied your app to get location or disabled the services location or the phone is in airplane mode
            print("Location denied")
            needLocationPermission = true

        case .authorizedAlways:  //This authorization allows you to use all location services and receive location events whether or not your app is in use.
            print("Location authorizedAlways")
            needLocationPermission = false

        case .authorizedWhenInUse:  //This authorization allows you to use all location services and receive location events only when your app is in use
            print("Location authorized when in use")
            needLocationPermission = false
            lastKnownLocation = manager.location
            if let location = lastKnownLocation { getCountry(from: location) }

        @unknown default:
            print("Location service disabled")

        }
    }

    //Trigged every time authorization status changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }


    //Get country name from location
    func getCountry(from location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let country = placemarks?.first?.country {
                DispatchQueue.main.async {
                    self.countryName = country
                }
            }
        }
    }
}
