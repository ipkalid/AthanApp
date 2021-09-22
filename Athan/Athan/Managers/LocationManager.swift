import Foundation
import CoreLocation





class LocationManager: NSObject,CLLocationManagerDelegate {
    var manager: CLLocationManager?
    
    
    
    
    func checkIfLocationManagerEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            manager = CLLocationManager()
            manager!.delegate = self
            
        }
        else {
            print("Fuck")
        }
    }
    
    
    
    private func checkLocationAuthorization() {
        guard  let locationManager = manager else {return}
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways, .authorizedWhenInUse:
            print(locationManager.location?.coordinate)
            
        @unknown default:
            break
        }
        
    }
    
    
    
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
        print("locationManagerDidChangeAuthorization")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
       // region = MKCoordinateRegion(center: (manager.location!.coordinate), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    }

}


//class LocationManager: NSObject , CLLocationManagerDelegate {
//    private var manager:CLLocationManager?
//    var location:CLLocation?
//    var cityName:String?
//
//
//    override init() {
//        super.init()
//        manager = CLLocationManager()
//        manager!.delegate = self
//    }
//
//
//    func checkIfLocationManagerEnabled(){
//        if CLLocationManager.locationServicesEnabled(){
//
//            print("locationServicesEnabled")
//
//
//        }
//        else {
//            print(" NOT locationServicesEnabled")
//        }
//    }
//
//    private func checkLocationAuthorization() {
//         guard  let locationManager = manager else {return}
//         switch locationManager.authorizationStatus {
//         case .notDetermined:
//            print("notDetermined")
//             locationManager.requestWhenInUseAuthorization()
//         case .restricted:
//             print("restricted")
//         case .denied:
//             print("denied")
//         case .authorizedAlways, .authorizedWhenInUse:
//             locationManager.requestLocation()
//
//         @unknown default:
//            break
//         }
//
//     }
//
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Failed to find user's location: \(error.localizedDescription)")
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        print("ff")
//        checkLocationAuthorization()
//    }
//
//
////    private  func getCityName(_ location: CLLocation) {
////        CLGeocoder()
////            .reverseGeocodeLocation(location) { placemarks, error in
////
////                guard error == nil else {
////                    print("*** Error in \(#function): \(error!.localizedDescription)")
////
////                    return
////                }
////
////                guard let placemark = placemarks?[0] else {
////                    print("*** Error in \(#function): placemark is nil")
////                    return
////                }
////                self.cityName = placemark.locality!
////
////            }
////    }
////
//}
