import Foundation

import Adhan
import SwiftUI

struct PrayerTimeCard: View {
    var prayers: PrayerTimes

    var body: some View {
        VStack(spacing: 0) {
            Group {
                PrayerTimeCell(salahTime: prayers.fajr, prayer: .fajr)
                Divider()
                PrayerTimeCell(salahTime: prayers.sunrise, prayer: .sunrise)
                Divider()
            }
            Group {
                PrayerTimeCell(salahTime: prayers.dhuhr, prayer: .dhuhr)
                Divider()
                PrayerTimeCell(salahTime: prayers.asr, prayer: .asr)
                Divider()
                PrayerTimeCell(salahTime: prayers.maghrib, prayer: .maghrib)
                Divider()
                PrayerTimeCell(salahTime: prayers.isha, prayer: .isha)
            }
        }
        .mainCardView(withPadding: false)
//        .modifier(MainCardStyle())
    }
}
