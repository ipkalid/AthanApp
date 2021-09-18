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
    
    
    var location: CLLocationCoordinate2D?
    var cityName: String?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        if CLLocationManager.locationServicesEnabled(){
            manager.requestWhenInUseAuthorization()
            location = manager.location?.coordinate
            getCityName();
            
            
        }else{
            print("Not enabled")
        }
    }
    
    func getCityName(){
        if(location != nil){
            CLGeocoder().reverseGeocodeLocation(manager.location!,
                                                completionHandler: { (placemarks, error) in
                                                    if error == nil {
                                                        self.cityName = placemarks![0].locality!
                                                    }else{
                                                        print("Oh Shit, We're F**ked")
                                                    }
                                                }
            )
            
        }else{
            print("Oh Shit, We're F**ked")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
}
