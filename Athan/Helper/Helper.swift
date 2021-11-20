//
//  SettingHelper.swift
//  Athan
//
//  Created by Khalid Alhazmi on 22/10/2021.
//

import Foundation
import UIKit

struct Helper {
    static func goToAppSetting() {
        DispatchQueue.main.async {
            if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings)
            }
        }
    }

    static func isArabic() -> Bool {
        if let local = Locale.current.languageCode {
            if local == "ar" {
                return true
            }
        }
        return false
    }
}
