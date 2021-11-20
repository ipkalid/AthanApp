import Adhan
import CoreLocation
import Foundation
import SwiftUI

class EnvViewModel: ObservableObject {
    static let shared = EnvViewModel()
    @Published var prayers: PrayerTimes?
    // First Lunch
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

    private var locationManager = LocationManager.instance
    private var notificationManager = NotificationManager.instance
    private var isArabic: Bool

    init() {
        isArabic = Helper.isArabic()
        guard
            let latitude = self.latitude,
            let longitude = self.longitude
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
            beforePrayerTimeReminder = " Prayer After Time 10 Minutes"
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

    func addNewPrayersNotification(calculationMethod: CalculationMethod = .ummAlQura) {
        guard let latitude = self.latitude,
              let longitude = self.longitude
        else {
            return
        }

        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let coordinates = Coordinates(latitude: latitude, longitude: longitude)
        let params = calculationMethod.params
        notificationManager.removeAllNotification()
        notificationManager.removeAllDeliveredNotifications()
        let minusTenMins: Double = -10 * 60
        for i in 0 ..< 5 {
            guard let modifiedDate = Calendar.current.date(byAdding: .day, value: i, to: Date()) else { return }
            let date = cal.dateComponents([.year, .month, .day], from: modifiedDate)
            guard let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) else { return }
            if fajrNotification {
                let notificationMessages = notificationMessages(prayer: .fajr)
                let titleReminder = notificationMessages[0]
                let prayerTimeReminder = notificationMessages[1]
                let beforePrayerTimeReminder = notificationMessages[2]
                notificationManager.scheduleNewNotification(titlt: titleReminder, body: prayerTimeReminder, date: prayers.fajr)
                if beforeFajrNotification {
                    notificationManager.scheduleNewNotification(titlt: titleReminder, body: beforePrayerTimeReminder, date: prayers.fajr.addingTimeInterval(minusTenMins))
                }
            }

            if dhuhrNotification {
                let notificationMessages = notificationMessages(prayer: .dhuhr)
                let titleReminder = notificationMessages[0]
                let prayerTimeReminder = notificationMessages[1]
                let beforePrayerTimeReminder = notificationMessages[2]
                notificationManager.scheduleNewNotification(titlt: titleReminder, body: prayerTimeReminder, date: prayers.dhuhr)
                if beforeDhuhrNotification {
                    notificationManager.scheduleNewNotification(titlt: titleReminder, body: beforePrayerTimeReminder, date: prayers.dhuhr.addingTimeInterval(minusTenMins))
                }
            }

            if asrNotification {
                let notificationMessages = notificationMessages(prayer: .asr)
                let titleReminder = notificationMessages[0]
                let prayerTimeReminder = notificationMessages[1]
                let beforePrayerTimeReminder = notificationMessages[2]
                notificationManager.scheduleNewNotification(titlt: titleReminder, body: prayerTimeReminder, date: prayers.asr)
                if beforeAsrNotification {
                    notificationManager.scheduleNewNotification(titlt: titleReminder, body: beforePrayerTimeReminder, date: prayers.asr.addingTimeInterval(minusTenMins))
                }
            }

            if maghribNotification {
                let notificationMessages = notificationMessages(prayer: .maghrib)
                let titleReminder = notificationMessages[0]
                let prayerTimeReminder = notificationMessages[1]
                let beforePrayerTimeReminder = notificationMessages[2]
                notificationManager.scheduleNewNotification(titlt: titleReminder, body: prayerTimeReminder, date: prayers.maghrib)
                if beforeMaghribNotification {
                    notificationManager.scheduleNewNotification(titlt: titleReminder, body: beforePrayerTimeReminder, date: prayers.maghrib.addingTimeInterval(minusTenMins))
                }
            }

            if ishaNotification {
                let notificationMessages = notificationMessages(prayer: .isha)
                let titleReminder = notificationMessages[0]
                let prayerTimeReminder = notificationMessages[1]
                let beforePrayerTimeReminder = notificationMessages[2]
                notificationManager.scheduleNewNotification(titlt: titleReminder, body: prayerTimeReminder, date: prayers.isha)
                if beforeIshaNotification {
                    notificationManager.scheduleNewNotification(titlt: titleReminder, body: beforePrayerTimeReminder, date: prayers.isha.addingTimeInterval(minusTenMins))
                }
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
                notificationManager.scheduleNewNotification(titlt: "أذكار الصباح", body: "أذكر الله يحفظك", date: date)
            } else {
                notificationManager.scheduleNewNotification(titlt: "Evening Athkar", body: "Evening Athkar Time", date: date)
            }
        }
        guard let modifiedDate = Calendar.current.date(byAdding: .day, value: 11, to: Date()) else { return }

        if isArabic {
            notificationManager.scheduleNewNotification(titlt: "أفتح التطبيق", body: "الرجاء فتح التطبيق من أجل إستمرار الإشعارات", date: modifiedDate)
        } else {
            notificationManager.scheduleNewNotification(titlt: "Open The App", body: "open the app to continue receiving the notifications", date: modifiedDate)
        }
    }
}
