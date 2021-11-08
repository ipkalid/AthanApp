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
            case .authorized:completionHandler(false, nil, .authorized)
                return

            default:
                return
            }
        }
    }

    func scheduleNewNotification(udid: String = UUID().uuidString, titlt: String, body: String, date: Date, rerepeats: Bool = false) {
        let content = UNMutableNotificationContent()
        content.title = titlt
        content.body = body
        content.sound = .default

        let calendar = Calendar.current

        var dateComponents = DateComponents()

        dateComponents.month = calendar.component(.month, from: date)
        dateComponents.day = calendar.component(.day, from: date)
        dateComponents.hour = calendar.component(.hour, from: date)
        dateComponents.minute = calendar.component(.minute, from: date)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: rerepeats)

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
