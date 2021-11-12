import CoreLocation
import Foundation
import SwiftUI

class LocationManager: NSObject {
    static let instance = LocationManager()

    private var manger = CLLocationManager()

    var onUpdateLocation: ((_ location: CLLocation) -> Void)?

    override init() {
        super.init()
        manger.delegate = self
        manger.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }

    func requestLocation(onUpdateLocation: @escaping (_ location: CLLocation) -> Void, completionHandler: @escaping (_ authorizationStatus: CLAuthorizationStatus) -> Void) {
        let status = manger.authorizationStatus
        switch status {
        case .notDetermined:
            self.onUpdateLocation = onUpdateLocation
            manger.requestAlwaysAuthorization()
            completionHandler(.notDetermined)
        case .authorizedWhenInUse, .authorizedAlways, .authorized:
            self.onUpdateLocation = onUpdateLocation
            manger.requestLocation()
            completionHandler(.authorizedAlways)
        case .denied: completionHandler(.denied)

        default:
            return
        }
    }

    static func getCityName(latitude: Double, longitude: Double, completion: @escaping (_ city: String) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        print(location)

        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                debugPrint("Error: " + error.localizedDescription)
                return
            }
            guard let placemarks = placemarks,
                  let place = placemarks.first,
                  let city = place.locality
            else { return }
            completion(city)
        }
    }

    static func showLocationDeniedAlert() -> Alert {
        return Alert(title: Text("Activate Location Services"),
                     message: Text("Plese activate the location Services from setting"),
                     primaryButton: .default(Text("Move to Setting"), action: Helper.goToAppSetting),
                     secondaryButton: .cancel(Text("Back"))
        )
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        if let onUpdateLocation = onUpdateLocation {
            onUpdateLocation(location)
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let location = manager.location else { return }
        if let onUpdateLocation = onUpdateLocation {
            onUpdateLocation(location)
        }
    }

    func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Error: " + error.localizedDescription)
    }
}
