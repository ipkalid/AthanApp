import CoreLocation
import Foundation

class LocationManager: NSObject {
    static let instance = LocationManager()
    
    private var manger = CLLocationManager()
    
    
    var cityName:String?
    
    var onUpdateLocation: ((_ location: CLLocation) -> Void)?
    var onFailWithError: (() -> Void)?
    var onAuthorizationDenied: (() -> Void)?
    
    
    override init() {
        super.init()
        manger.delegate = self
    }
    
    func requestLocation() {
        let status = manger.authorizationStatus
        switch status {
        case .notDetermined:
            manger.requestAlwaysAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            manger.requestLocation()
        case.denied:
            if let onAuthorizationDenied = onAuthorizationDenied {
                onAuthorizationDenied()
            }
        default:
            return
        }
    }
    
    func getCityName() {
        guard let location = manger.location else {return};
        let locale = Locale(identifier: "ar_sa")
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, error in
            if let error = error {
                debugPrint("Error: " + error.localizedDescription)
                return
            }
            guard let placemarks = placemarks,
                  let place = placemarks.first,
                  let city = place.locality
            else{return}
            
            self.cityName = city
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        if let onUpdateLocation = onUpdateLocation {
            onUpdateLocation(location)
            getCityName()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let location = manager.location else { return }
        if let onUpdateLocation = onUpdateLocation {
            onUpdateLocation(location)
            getCityName()
        }
    }
    
    func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        if let onFailWithError = onFailWithError{
            onFailWithError();
        }
        debugPrint("Error: " + error.localizedDescription)
    }
}
