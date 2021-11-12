//
//  PrayerTime.swift
//  Athan
//
//  Created by Khalid Alhazmi on 18/09/2021.
//

import Adhan
import Foundation

struct PrayerTimesInMonth {
    var PrayerTime: [PrayerTimes]
    var satringDate: Date
}

enum Prayer {
    case fajr
    case dhuhr
    case asr
    case maghrib
    case isha
}
