//
//  QiblahView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 19/01/2023.
//

import CoreLocation
import Foundation
import SwiftUI

class QiblahViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var degrees: Double = .zero
    @Published var headingDegree: Double = .zero
    @Published var cityName: String?

    var cuttentLocation: CLLocation?

    var differentDegree: Double {
        let diff = headingDegree - degrees
        return diff < 180 ? diff : diff - 360
    }

    var isLessThan2: Bool { abs(differentDegree) < 2 }
    var isMoreThan25: Bool { abs(differentDegree) > 25 }

    var isNegative: Bool { differentDegree < 0 }

    func getCityName() {
        if let _ = cityName {
            return
        }
        guard let cuttentLocation else {
            return
        }

        Task {
            let placemarks = try? await geocoder.reverseGeocodeLocation(cuttentLocation)
            if let placemarks = placemarks,
               let place = placemarks.first,
               let city = place.locality {
                await MainActor.run {
                    cityName = city
                }
            }
        }
    }

    private let _constKaabaLocation = CLLocation(latitude: 21.4225, longitude: 39.8262)

    private let locationManager: CLLocationManager
    private let geocoder: CLGeocoder
    override init() {
        locationManager = CLLocationManager()
        geocoder = CLGeocoder()
        super.init()

        locationManager.delegate = self
        setup()
    }

    private func setup() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters

        startUpdating(true)
    }

    func startUpdating(_ state: Bool) {
        if CLLocationManager.headingAvailable() {
            if state {
                locationManager.startUpdatingHeading()
                locationManager.startUpdatingLocation()
                return
            }
            locationManager.stopUpdatingHeading()
            locationManager.stopUpdatingLocation()
        }
    }

    private func convertToRadius(_ degree: Double) -> Double {
        degree * Double.pi / 180
    }

    private func convertToDegree(_ radian: Double) -> Double {
        radian * 180 / Double.pi
    }

    /// Let ‘R’ be the radius of Earth,
    /// ‘L’ be the longitude,
    /// ‘θ’ be latitude,
    /// ‘β‘ be Bearing.
    /// β = atan2(X,Y),
    /// X = cos θb * sin ∆L
    /// Y = cos θa * sin θb – sin θa * cos θb * cos ∆L
    /// source: https://www.igismap.com/formula-to-find-bearing-or-heading-angle-between-two-points-latitude-longitude/
    ///
    /// A is Makkah
    /// B is MyLocation
    private func getHeadingAngle() {
        guard let cuttentLocation else { return }

        let _θa = convertToRadius(_constKaabaLocation.coordinate.latitude)
        let _La = convertToRadius(_constKaabaLocation.coordinate.longitude)

        let _θb = convertToRadius(cuttentLocation.coordinate.latitude)
        let _Lb = convertToRadius(cuttentLocation.coordinate.longitude)

        let x = cos(_θb) * sin(abs(_Lb - _La))
        let y = cos(_θa) * sin(_θb) - sin(_θa) * cos(_θb) * cos(abs(_Lb - _La))

        let _β = atan2(x, y)
        headingDegree = convertToDegree(_β)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            cuttentLocation = firstLocation
            getHeadingAngle()
            getCityName()
            locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        degrees = newHeading.magneticHeading - 180

        if !isMoreThan25 {
            if isLessThan2 {
                UINotificationFeedbackGenerator().notificationOccurred(.success)
                return
            }
            if floor(abs(differentDegree).truncatingRemainder(dividingBy: 5)) == 1 {
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            }
        }
    }
}

struct QiblahView: View {
    @StateObject var vm = QiblahViewModel()

    var moreThan25Degree: Bool {
        abs(vm.differentDegree) > 25
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                if let cityName = vm.cityName {
                    Text("Location")

                        .foregroundColor(Color.white.opacity(0.8))
                    Text(cityName)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(AppColors.yellow)
                    HStack {
                        Spacer()
                    }
                }

            }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)

            Spacer()
                .frame(height: 90)

            CompassView()
                .environmentObject(vm)

            VStack {
                Text("\(abs(vm.differentDegree), specifier: "%0.f")°")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(AppColors.yellow)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack {
                    Text(vm.isLessThan2 ? "facing" : "to your")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(AppColors.yellow.opacity(0.8))

                    Text(vm.isLessThan2 ? "Qiblah" : vm.isNegative ? "left" : "right")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(AppColors.yellow)

                    Spacer()
                }
            }

            HStack {
                Spacer()
            }
        }
        .padding()
        .padding()
        .background(vm.isMoreThan25 ? AppColors.qibllahFarBackGroundColor.ignoresSafeArea() : AppColors.backgroundColor.ignoresSafeArea())
        .onAppear {
            vm.startUpdating(true)
        }
        .onDisappear {
            vm.startUpdating(false)
        }
    }
}

struct CompassView: View {
    @EnvironmentObject var vm: QiblahViewModel
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let trimStaring = 0.035
            let trimFinal = abs(vm.differentDegree) / 360

            ZStack {
                Circle()
                    .trim(from: trimStaring, to: trimFinal)
                    .stroke(
                        AppColors.yellow.opacity(0.8),
                        style: StrokeStyle(
                            lineWidth: 25,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(Helper.isArabic() ? 90 : -90))
                    .scaleEffect(x: Helper.isArabic() ? vm.isNegative ? -1 : 1 : vm.isNegative ? 1 : -1, y: 1, anchor: .center)

//                    .scale(x: -1, y: 1, anchor: .center)
//                    .rotation3DEffect(.degrees(vm.isNegative ? 0 : 0), axis: (x: 0, y: 1, z: 0))

                ZStack {
                    if #available(iOS 16.0, *) {
                        Image(systemName: "arrow.up")
                            .resizable()
                            .fontWeight(.bold)
                            .foregroundColor(AppColors.yellow)
                            .padding(60)

                    } else {
                        Image(systemName: "arrow.up")
                            .resizable()
                            .foregroundColor(.white)
                            .padding(60)
                    }

                    CompassTargetView()
                        .frame(width: 30, height: 30, alignment: .center)
                        .offset(y: -width / 2)
                }
                .rotationEffect(.degrees(vm.degrees - vm.headingDegree))

                Text("🕋")
                    .font(.system(size: 45))
                    .foregroundColor(.black.opacity(0.7))
                    .offset(y: -width / 2)
            }
            .frame(width: width, height: width, alignment: .center)
        }
    }
}

struct CompassTargetView: View {
    @State var timer = Timer.publish(every: 0.75, on: .main, in: .common).autoconnect()
    @State var showEffect: Bool = true
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(AppColors.yellow)

            Circle()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(AppColors.yellow)
                .opacity(showEffect ? 0.75 : 0)
                .scaleEffect(showEffect ? 1 : 5)
        }
        .onReceive(timer) { _ in

            if showEffect {
                withAnimation {
                    showEffect.toggle()
                }
            } else {
                showEffect.toggle()
            }
        }
    }
}

struct QiblahView_Previews: PreviewProvider {
    static var previews: some View {
        QiblahView()
    }
}
