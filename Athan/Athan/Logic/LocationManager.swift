//
//  LocationManager.swift
//  Athan
//
//  Created by Khalid Alhazmi on 14/09/2021.
//

import Foundation
import CoreLocation
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        if CLLocationManager.locationServicesEnabled(){
            manager.requestWhenInUseAuthorization()

            print("\(manager.location?.coordinate.latitude), \(manager.location?.coordinate.latitude)")
        }else{
            print("Not enabled")
        }
  //      print("manager.location as Any");
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
}
