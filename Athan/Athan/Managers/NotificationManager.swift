//
//  NotificationManager.swift
//  Athan
//
//  Created by Khalid Alhazmi on 20/10/2021.
//

import Foundation
import UIKit
import UserNotifications
import SwiftUI

struct NOTOTO:View{
    
    var cen = NotificationManager.instance
    var body: some View{
        Button("Add Notidication"){
            
            // Creating Content
            let content = UNMutableNotificationContent()
            content.title = "Weekly Staff Meeting"
            content.body = "Every Tuesday at 2pm"
            content.sound = .default
            
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current

            dateComponents.weekday = 3  // Tuesday
            dateComponents.hour = 14    // 14:00 hours
               
            // Create the trigger as a repeating event.
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            

           // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)


            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )

            cen.center.add(request) { error in
                if let error = error {
                    debugPrint("Error: \(error.localizedDescription)")
                }
                cen.center.getPendingNotificationRequests { requests in
                    print(requests.count)
                }
            }
        }
    }
}



class NotificationManager {
    static let instance = NotificationManager()

    let center = UNUserNotificationCenter.current()

    func requestAuthorization() {
        center.getNotificationSettings { setting in
            switch setting.authorizationStatus {
            case .notDetermined: self.showRequestAuthorizationAlert()
            case .denied: Helper.goToAppSetting()
            case .authorized:
                print("ddd")

            default:
                return
            }
        }
    }

    func scheduleNewNotification(udid:String = UUID().uuidString, titlt:String, body:String, date: Date,rerepeats:Bool = false) {
        let content = UNMutableNotificationContent()
        content.title = titlt
        content.body = body
        content.sound = .default
        
        //let dateComponents = Calendar.current.dateComponents(in: .current, from: date)
        
      
        let calendar = Calendar.current
        
        var dateComponents = DateComponents();
        
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
            self.center.getPendingNotificationRequests { requests in
                print(requests.count)
            }
        }
    }

    func removeNotificationById(_ id: String) {
        center.removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    func removeAllNotification() {
        center.removeAllPendingNotificationRequests()
    }


    private func showRequestAuthorizationAlert() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        center.requestAuthorization(options: options) { success, error in
            if let error = error {
                debugPrint("Error: \(error.localizedDescription)")
            } else {
                debugPrint("Success: \(success.description)")
            }
        }
    }
}
