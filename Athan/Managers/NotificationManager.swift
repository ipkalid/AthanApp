//
//  NotificationManager.swift
//  Athan
//
//  Created by Khalid Alhazmi on 20/10/2021.
//

import Foundation
import SwiftUI
import UIKit
import UserNotifications

enum CustomNotificationSound: String, CaseIterable, Identifiable {
    var id: String {
        switch self {
        case .defualtSound:
            return "defualtSound"
        case .makkah:
            return "makkah"
        case .maddinah:
            return "maddinah"
        case .alaqsa:
            return "alaqsa"
        }
    }

    case defualtSound = "defualt"
    case makkah = "Makkah"
    case maddinah = "Maddinah"
    case alaqsa = "Alaqsa"

    var localizedStringKey: LocalizedStringKey {
        switch self {
        case .defualtSound:
            return LocalizedStringKey("Defualt Sound")
        case .makkah:
            return LocalizedStringKey("Makkah's Athan")
        case .maddinah:
            return LocalizedStringKey("Madinah's Athan")
        case .alaqsa:
            return LocalizedStringKey("Alaqsa's Athan")
        }
    }

    var notificationSoundName: UNNotificationSoundName {
        switch self {
        case .defualtSound:
            return UNNotificationSoundName("tri_tone.caf")
        case .makkah:
            return UNNotificationSoundName("Athan_makkah.caf")
        case .maddinah:
            return UNNotificationSoundName("Athan_madina.caf")
        case .alaqsa:
            return UNNotificationSoundName("Athan_alaqsa.caf")
        }
    }

    var urlPath: URL? {
        switch self {
        case .makkah:
            return Bundle.main.url(forResource: "Athan_makkah", withExtension: "caf")
        case .maddinah:
            return Bundle.main.url(forResource: "Athan_madina", withExtension: "caf")
        case .alaqsa:
            return Bundle.main.url(forResource: "Athan_alaqsa", withExtension: "caf")
        case .defualtSound:
            return Bundle.main.url(forResource: "tri_tone", withExtension: "caf")
        }
    }
}

class NotificationManager {
    static let instance = NotificationManager()

    let center = UNUserNotificationCenter.current()

    func requestAuthorization(completionHandler: @escaping (_ granted: Bool, _ error: Error?, _ authorizationStatus: UNAuthorizationStatus) -> Void) {
        center.getNotificationSettings { setting in
            switch setting.authorizationStatus {
            case .notDetermined: self.showRequestAuthorizationAlert { granted, error in
                    completionHandler(granted, error, .notDetermined)
                }
            case .denied: completionHandler(false, nil, .denied)
            case .authorized: completionHandler(false, nil, .authorized)
                return

            default:
                return
            }
        }
    }

    func scheduleNewNotification(udid: String = UUID().uuidString, titlt: String, body: String, date: Date, notificationSound: CustomNotificationSound?) {
        let content = UNMutableNotificationContent()
        content.title = titlt
        content.body = body
        if let notificationSound {
            let notificationSound = UNNotificationSound(named: notificationSound.notificationSoundName)
            content.sound = notificationSound
        } else {
            content.sound = .default
        }

        let calendar = Calendar.current

        var dateComponents = DateComponents()

        dateComponents.month = calendar.component(.month, from: date)
        dateComponents.day = calendar.component(.day, from: date)
        dateComponents.hour = calendar.component(.hour, from: date)
        dateComponents.minute = calendar.component(.minute, from: date)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(
            identifier: udid,
            content: content,
            trigger: trigger
        )
        center.add(request) { error in
            if let error = error {
                debugPrint("Error: \(error.localizedDescription)")
            }
        }
    }

    func scheduleNewNotification(udid: String = UUID().uuidString, titlt: String, body: String, date: DateComponents) {
        let content = UNMutableNotificationContent()
        content.title = titlt
        content.body = body
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)

        let request = UNNotificationRequest(
            identifier: udid,
            content: content,
            trigger: trigger
        )
        center.add(request) { error in
            if let error = error {
                debugPrint("Error: \(error.localizedDescription)")
            }
        }
    }

    func removeNotificationById(_ id: String) {
        center.removePendingNotificationRequests(withIdentifiers: [id])
    }

    func removeAllDeliveredNotifications() {
        center.removeAllDeliveredNotifications()
    }

    func removeAllNotification() {
        center.removeAllPendingNotificationRequests()
    }

    private func showRequestAuthorizationAlert(completionHandler: @escaping (_ granted: Bool, Error?) -> Void) {
        let options: UNAuthorizationOptions = [.alert, .sound]
        center.requestAuthorization(options: options, completionHandler: completionHandler)
    }

    static func showNotificationDeniedAlert() -> Alert {
        return Alert(title: Text("Activate Notifications"),
                     message: Text("Plese activate the notifications from setting"),
                     primaryButton: .default(Text("Move to Setting"), action: Helper.goToAppSetting),
                     secondaryButton: .cancel(Text("Back"))
        )
    }
}
