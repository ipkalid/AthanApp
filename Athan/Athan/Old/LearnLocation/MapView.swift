import CoreLocation
import MapKit
import SwiftUI

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 24.797761, longitude: 46.741433), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    @StateObject private var viewModel = MapView.ViewModel()

    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .onAppear {
                viewModel.checkIfLocationManagerEnabled()
            }
    }
}

extension MapView {
    class ViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
        var locationManager = MLocationManager()

        @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 24.797761, longitude: 46.741433), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

        func checkIfLocationManagerEnabled() {
            locationManager.checkIfLocationManagerEnabled()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

class MLocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?

    func checkIfLocationManagerEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Fuck")
        }
    }

    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways, .authorizedWhenInUse:
            print("authorizedAlways")
            // locationManager.startUpdatingLocation()
            // print(locationManager.location?.coordinate)

        @unknown default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_: CLLocationManager) {
        checkLocationAuthorization()
        print("locationManagerDidChangeAuthorization")
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        // region = MKCoordinateRegion(center: (manager.location!.coordinate), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    }
}
