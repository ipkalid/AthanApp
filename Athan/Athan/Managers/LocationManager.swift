import CoreLocation
import Foundation

class LocstionManager: NSObject, CLLocationManagerDelegate {
    private var locationManger = CLLocationManager()

    override init() {
        super.init()
        locationManger.delegate = self
    }

    func getLocation() {
        locationManger.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let location = manager.location else { return }
        print(location)
    }

    func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//
//
// class LocationManager: NSObject,CLLocationManagerDelegate {
//    var manager: CLLocationManager = CLLocationManager()
//    var currentLocation: CLLocation?
//
//
//    override init() {
//        super.init()
//        manager.delegate = self
//    }
//
//
//
//    public func requestLocation(){
//        manager.requestLocation()
//    }
//
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let latestLocation = locations.last else {return}
//        currentLocation = latestLocation
//        print(latestLocation);
//    }
//
//
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error happend")
//        print(error.localizedDescription)
//    }
//
//
//
////    private func checkLocationAuthorization() {
////          let locationManager = manager
////        switch locationManager.authorizationStatus {
////        case .notDetermined:
////            locationManager.requestWhenInUseAuthorization()
////        case .restricted:
////            print("restricted")
////        case .denied:
////            print("denied")
////        case .authorizedAlways, .authorizedWhenInUse:
////            print(locationManager.location?.coordinate)
////
////        @unknown default:
////            break
////        }
////
////    }
////
//
//
//
//
////    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
////        checkLocationAuthorization()
////        print("locationManagerDidChangeAuthorization")
////    }
//
// }
//
//
////class LocationManager: NSObject , CLLocationManagerDelegate {
////    private var manager:CLLocationManager?
////    var location:CLLocation?
////    var cityName:String?
////
////
////    override init() {
////        super.init()
////        manager = CLLocationManager()
////        manager!.delegate = self
////    }
////
////
////    func checkIfLocationManagerEnabled(){
////        if CLLocationManager.locationServicesEnabled(){
////
////            print("locationServicesEnabled")
////
////
////        }
////        else {
////            print(" NOT locationServicesEnabled")
////        }
////    }
////
////    private func checkLocationAuthorization() {
////         guard  let locationManager = manager else {return}
////         switch locationManager.authorizationStatus {
////         case .notDetermined:
////            print("notDetermined")
////             locationManager.requestWhenInUseAuthorization()
////         case .restricted:
////             print("restricted")
////         case .denied:
////             print("denied")
////         case .authorizedAlways, .authorizedWhenInUse:
////             locationManager.requestLocation()
////
////         @unknown default:
////            break
////         }
////
////     }
////
////
////    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
////        print("Failed to find user's location: \(error.localizedDescription)")
////    }
////
////    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
////        print("ff")
////        checkLocationAuthorization()
////    }
////
////
//////    private  func getCityName(_ location: CLLocation) {
//////        CLGeocoder()
//////            .reverseGeocodeLocation(location) { placemarks, error in
//////
//////                guard error == nil else {
//////                    print("*** Error in \(#function): \(error!.localizedDescription)")
//////
//////                    return
//////                }
//////
//////                guard let placemark = placemarks?[0] else {
//////                    print("*** Error in \(#function): placemark is nil")
//////                    return
//////                }
//////                self.cityName = placemark.locality!
//////
//////            }
//////    }
//////
////}
