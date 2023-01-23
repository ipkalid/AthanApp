import Adhan
import CoreLocation
import Foundation
import SwiftUI

class EnvViewModel: ObservableObject {
    static let shared = EnvViewModel()
    @Published var prayers: PrayerTimes?
    @AppStorage(UserDefaultsKey.showOnboarding) var showOnboarding: Bool = true

    @AppStorage(UserDefaultsKey.cityName) var cityName: String?

    @AppStorage(UserDefaultsKey.latitude) private var latitude: Double?
    @AppStorage(UserDefaultsKey.longitude) private var longitude: Double?

    @AppStorage(UserDefaultsKey.morningAthkar) var morningAthkar: Bool = false {
        didSet {
            addNewPrayersNotification()
        }
    }

    @AppStorage(UserDefaultsKey.eveningAthkar) var eveningAthkar: Bool = false {
        didSet {
            addNewPrayersNotification()
        }
    }

    @AppStorage(UserDefaultsKey.fajrNotification) var fajrNotification: Bool = true {
        didSet {
            addNewPrayersNotification()
        }
    }

    @AppStorage(UserDefaultsKey.beforeFajrNotification) var beforeFajrNotification: Bool = false {
        didSet {
            addNewPrayersNotification()
        }
    }

    @AppStorage(UserDefaultsKey.dhuhrNotification) var dhuhrNotification: Bool = true {
        didSet {
            addNewPrayersNotification()
        }
    }

    @AppStorage(UserDefaultsKey.beforeDhuhrNotification) var beforeDhuhrNotification: Bool = false {
        didSet {
            addNewPrayersNotification()
        }
    }

    @AppStorage(UserDefaultsKey.asrNotification) var asrNotification: Bool = true {
        didSet {
            addNewPrayersNotification()
        }
    }

    @AppStorage(UserDefaultsKey.beforeAsrNotification) var beforeAsrNotification: Bool = false {
        didSet {
            addNewPrayersNotification()
        }
    }

    @AppStorage(UserDefaultsKey.maghribNotification) var maghribNotification: Bool = true {
        didSet {
            addNewPrayersNotification()
        }
    }

    @AppStorage(UserDefaultsKey.beforeMaghribNotification) var beforeMaghribNotification: Bool = false {
        didSet {
            addNewPrayersNotification()
        }
    }

    @AppStorage(UserDefaultsKey.ishaNotification) var ishaNotification: Bool = true {
        didSet {
            addNewPrayersNotification()
        }
    }

    @AppStorage(UserDefaultsKey.beforeIshaNotification) var beforeIshaNotification: Bool = false {
        didSet {
            addNewPrayersNotification()
        }
    }

    @AppStorage(UserDefaultsKey.audioName) var audioName: CustomNotificationSound = .defualtSound {
        didSet {
            addNewPrayersNotification()
        }
    }

    private var locationManager = LocationManager.instance
    private var notificationManager = NotificationManager.instance
    private var isArabic: Bool

    init() {
        isArabic = Helper.isArabic()
        guard
            let latitude = latitude,
            let longitude = longitude
        else { return }

        LocationManager.getCityName(latitude: latitude, longitude: longitude) { city in
            self.cityName = city
        }
        showPrayerTime(latitude: latitude, longitude: longitude)
        addNewPrayersNotification()
    }

    func updateLocation(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        LocationManager.getCityName(latitude: latitude, longitude: longitude) { city in
            self.cityName = city
        }

        showPrayerTime(latitude: latitude, longitude: longitude)
        addNewPrayersNotification()
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

    private func notificationMessages(prayer: Prayer) -> [String] {
        var titleReminder = ""
        var prayerTimeReminder = ""
        var beforePrayerTimeReminder = ""
        var prayerName = ""

        if isArabic {
            titleReminder = "أذان "
            prayerTimeReminder = "حان وقت أذان "
            beforePrayerTimeReminder = "١٠ دقائق على أذان "
            switch prayer {
            case .fajr:
                prayerName = "الفجر"
            case .sunrise:
                prayerName = "الشروق"
            case .dhuhr:
                prayerName = "الظهر"
            case .asr:
                prayerName = "العصر"
            case .maghrib:
                prayerName = "المغرب"
            case .isha:
                prayerName = "العشاء"
            }
            titleReminder = titleReminder + prayerName
            prayerTimeReminder = prayerTimeReminder + prayerName
            beforePrayerTimeReminder = beforePrayerTimeReminder + prayerName
        } else {
            titleReminder = " Prayer"
            prayerTimeReminder = " Prayer Time"
            beforePrayerTimeReminder = " Prayer Time After 10 Minutes"
            switch prayer {
            case .fajr:
                prayerName = "Fajr"
            case .sunrise:
                prayerName = "Sunrise"
            case .dhuhr:
                prayerName = "Dhuhr"
            case .asr:
                prayerName = "Asr"
            case .maghrib:
                prayerName = "Maghrib"
            case .isha:
                prayerName = "Isha"
            }
            titleReminder = prayerName + titleReminder
            prayerTimeReminder = prayerName + prayerTimeReminder
            beforePrayerTimeReminder = prayerName + beforePrayerTimeReminder
        }

        return [
            titleReminder,
            prayerTimeReminder,
            beforePrayerTimeReminder,
        ]
    }

    private func addNotification(prayer: Prayer, prayerDate: Date, beforeNotification: Bool) {
        let notificationMessages = notificationMessages(prayer: prayer)
        let titleReminder = notificationMessages[0]
        let prayerTimeReminder = notificationMessages[1]
        let beforePrayerTimeReminder = notificationMessages[2]
        notificationManager.scheduleNewNotification(titlt: titleReminder, body: prayerTimeReminder, date: prayerDate, notificationSound: audioName)
        if beforeNotification {
            notificationManager.scheduleNewNotification(titlt: titleReminder, body: beforePrayerTimeReminder, date: prayerDate.addingTimeInterval(-10 * 60), notificationSound: nil)
        }
    }

    private func addNewPrayersNotification(calculationMethod: CalculationMethod = .ummAlQura) {
        guard let latitude = latitude,
              let longitude = longitude
        else {
            return
        }

        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let coordinates = Coordinates(latitude: latitude, longitude: longitude)
        let params = calculationMethod.params
        notificationManager.removeAllNotification()
        notificationManager.removeAllDeliveredNotifications()
        for i in 0 ..< 5 {
            guard let modifiedDate = Calendar.current.date(byAdding: .day, value: i, to: Date()) else { return }
            let date = cal.dateComponents([.year, .month, .day], from: modifiedDate)
            guard let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) else { return }
            if fajrNotification {
                addNotification(prayer: .fajr, prayerDate: prayers.fajr, beforeNotification: beforeFajrNotification)
            }

            if dhuhrNotification {
                addNotification(prayer: .dhuhr, prayerDate: prayers.dhuhr, beforeNotification: beforeDhuhrNotification)
            }

            if asrNotification {
                addNotification(prayer: .asr, prayerDate: prayers.asr, beforeNotification: beforeAsrNotification)
            }

            if maghribNotification {
                addNotification(prayer: .maghrib, prayerDate: prayers.maghrib, beforeNotification: beforeMaghribNotification)
            }

            if ishaNotification {
                addNotification(prayer: .isha, prayerDate: prayers.isha, beforeNotification: beforeIshaNotification)
            }
        }
        if morningAthkar {
            var date = DateComponents()
            date.hour = 6
            date.minute = 30
            if isArabic {
                notificationManager.scheduleNewNotification(titlt: "أذكار الصباح", body: "أذكر الله يحفظك", date: date)
            } else {
                notificationManager.scheduleNewNotification(titlt: "Morning Athkar", body: "Morning Athkar Time", date: date)
            }
        }
        if eveningAthkar {
            var date = DateComponents()
            date.hour = 19
            date.minute = 30
            if isArabic {
                notificationManager.scheduleNewNotification(titlt: "أذكار المساء", body: "أذكر الله يحفظك", date: date)
            } else {
                notificationManager.scheduleNewNotification(titlt: "Evening Athkar", body: "Evening Athkar Time", date: date)
            }
        }
        guard let modifiedDate = Calendar.current.date(byAdding: .day, value: 11, to: Date()) else { return }

        if isArabic {
            notificationManager.scheduleNewNotification(titlt: "أفتح التطبيق", body: "الرجاء فتح التطبيق من أجل إستمرار الإشعارات", date: modifiedDate, notificationSound: nil)
        } else {
            notificationManager.scheduleNewNotification(titlt: "Open The App", body: "open the app to continue receiving the notifications", date: modifiedDate, notificationSound: nil)
        }
    }
}
