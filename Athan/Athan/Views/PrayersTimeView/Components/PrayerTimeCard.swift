import Foundation

import Adhan
import SwiftUI

struct PrayerTimeCard: View {
    var prayers: PrayerTimes

    var body: some View {
        VStack(spacing: 0) {
            PrayerTimeCell(salahTime: prayers.fajr, prayer: .fajr)
            Divider()
            PrayerTimeCell(salahTime: prayers.dhuhr, prayer: .dhuhr)
            Divider()
            PrayerTimeCell(salahTime: prayers.asr, prayer: .asr)
            Divider()
            PrayerTimeCell(salahTime: prayers.maghrib, prayer: .maghrib)
            Divider()
            PrayerTimeCell(salahTime: prayers.isha, prayer: .isha)
        }
        .modifier(MainCardStyle())
    }
}

// struct PrayerTimeList_Previews: PreviewProvider {
//    static var previews: some View {
//        PrayerTimeCard()
//    }
// }
