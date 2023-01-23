//
//  Prayer.swift
//  Athan
//
//  Created by Khalid Alhazmi on 18/01/2023.
//

import Foundation
import SwiftUI
import Adhan
extension Adhan.Prayer {
    var prayerName: LocalizedStringKey {
        switch self {
        case .fajr:
            return "Fajr"
        case .sunrise:
            return "Sunrise"
        case .dhuhr:
            return "Dhuhr"
        case .asr:
            return "Asr"
        case .maghrib:
            return "Maghrib"
        case .isha:
            return "Isha"
        }
    }

    var prayerIcon: String {
        switch self {
        case .fajr:
            return "sun.and.horizon.fill"
        case .sunrise:
            return "sunrise.fill"
        case .dhuhr:
            return "sun.max.fill"
        case .asr:
            return "cloud.sun.fill"
        case .maghrib:
            return "sunset.fill"
        case .isha:
            return "moon.stars.fill"
        }
    }
}
