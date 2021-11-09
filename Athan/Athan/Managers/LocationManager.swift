import CoreLocation
import Foundation
import SwiftUI

class LocationManager: NSObject {
    static let instance = LocationManager()

    private var manger = CLLocationManager()

    var cityName: String?

    var onUpdateLocation: ((_ location: CLLocation) -> Void)?
    var onAuthorizationDenied: (() -> Void)?

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

    private func getCityName() {
        guard let location = manger.location else { return }
        // let locale = Locale(identifier: "ar_sa")
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                debugPrint("Error: " + error.localizedDescription)
                return
            }
            guard let placemarks = placemarks,
                  let place = placemarks.first,
                  let city = place.locality
            else { return }

            self.cityName = city
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
        debugPrint("Error: " + error.localizedDescription)
    }
}
