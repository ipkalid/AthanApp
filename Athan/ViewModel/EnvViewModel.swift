import Adhan
import CoreLocation
import Foundation
import SwiftUI

class EnvViewModel: ObservableObject {
    static let shared = EnvViewModel()

    @Published var prayers: PrayerTimes?

    @AppStorage(UserDefaultsKey.showOnboarding) var showOnboarding: Bool?

    @AppStorage(UserDefaultsKey.cityName) var cityName: String?

    @AppStorage(UserDefaultsKey.latitude) var latitude: Double?
    @AppStorage(UserDefaultsKey.longitude) private var longitude: Double?

    private var locationManager = LocationManager.instance
    private var notificationManager = NotificationManager.instance

    init() {
        guard
            let latitude = latitude,
            let longitude = longitude
        else { return }

        LocationManager.getCityName(latitude: latitude, longitude: longitude) { city in
            self.cityName = city
        }
        showPrayerTime(latitude: latitude, longitude: longitude)
        addNewPrayersNotification(latitude: latitude, longitude: longitude)
    }

    func updateLocation(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        LocationManager.getCityName(latitude: latitude, longitude: longitude) { city in
            self.cityName = city
        }

        showPrayerTime(latitude: latitude, longitude: longitude)
        addNewPrayersNotification(latitude: latitude, longitude: longitude)
    }

    func requestNotification(completionHandler: @escaping (Bool, Error?, UNAuthorizationStatus) -> Void) {
        notificationManager.requestAuthorization(completionHandler: completionHandler)
    }

    func requestLocation(onUpdateLocation: @escaping (_ location: CLLocation) -> Void, completionHandler: @escaping (_ authorizationStatus: CLAuthorizationStatus) -> Void) {
        locationManager.requestLocation(onUpdateLocation: onUpdateLocation, completionHandler: completionHandler)
    }

    var calculationMethod = CalculationMethod.ummAlQura

    var madhabType = Madhab.shafi

    func showPrayerTime(latitude: Double, longitude: Double, calculationMethod: CalculationMethod = .ummAlQura) {
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let coordinates = Coordinates(latitude: latitude, longitude: longitude)
        let params = calculationMethod.params
        let date = cal.dateComponents([.year, .month, .day], from: Date.now)
        guard let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) else { return }
        self.prayers = prayers
    }

    func addNewPrayersNotification(latitude: Double, longitude: Double, calculationMethod: CalculationMethod = .ummAlQura) {
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let coordinates = Coordinates(latitude: latitude, longitude: longitude)
        let params = calculationMethod.params
        notificationManager.removeAllNotification()
        notificationManager.removeAllDeliveredNotifications()
        for i in 0 ..< 12 {
            guard let modifiedDate = Calendar.current.date(byAdding: .day, value: i, to: Date()) else { return }
            let date = cal.dateComponents([.year, .month, .day], from: modifiedDate)
            guard let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) else { return }
            notificationManager.scheduleNewNotification(titlt: "أذان الفجر", body: "حان موعد صلاة الفجر", date: prayers.fajr)
            notificationManager.scheduleNewNotification(titlt: "أذان الظهر", body: "حان موعد صلاة الظهر", date: prayers.dhuhr)
            notificationManager.scheduleNewNotification(titlt: "أذان العصر", body: "حان موعد صلاة العصر", date: prayers.asr)
            notificationManager.scheduleNewNotification(titlt: "أذان المغرب", body: "حان موعد صلاة المغرب", date: prayers.maghrib)
            notificationManager.scheduleNewNotification(titlt: "أذان العشاء", body: "حان موعد صلاة العشاء", date: prayers.isha)
        }
    }

    func getMadhabName() -> String {
        switch madhabType {
        case .shafi:
            return "حنبلي - مالكي - شافعي"
        case .hanafi:
            return "حنفي"
        }
    }

    func getCalculationMethod() -> String {
        switch calculationMethod {
        case .muslimWorldLeague:
            return "رابطة العالم الإسلامي"
        case .ummAlQura:
            return "أم القرى"
        case .dubai:
            return "دبي"
        case .kuwait:
            return "الكويت"
        case .qatar:
            return "قطر"
        default:
            return "Other"
        }
    }
}

//        locationManager.onUpdateLocation = { location in
//            self.showLocationIndicator = true
//            let latitude = location.coordinate.latitude
//            let longitude = location.coordinate.longitude
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                withAnimation(.linear) {
//                    self.showPrayerTime(
//                        latitude: latitude,
//                        longitude: longitude
//                    )
//                    self.latitude = latitude
//                    self.longitude = longitude
//                    self.addNewPrayersNotification(latitude: latitude, longitude: longitude)
//                }
//                self.showLocationIndicator = false
//                self.cityName = self.locationManager.cityName
//            }
//        }
//
//        locationManager.onAuthorizationDenied = {
//            self.showGoToSettingAlert = true
//        }
