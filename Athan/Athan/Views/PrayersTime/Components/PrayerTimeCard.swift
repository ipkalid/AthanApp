import Foundation

import SwiftUI
import Adhan

struct PrayerTimeCard: View {
    var prayers:PrayerTimes?

    var body: some View {
        VStack(spacing:0){
            PrayerTimeCell(salahTime: prayers!.fajr, prayer: .fajr)
            Divider()
            PrayerTimeCell(salahTime: prayers?.asr ?? Date(),prayer: .asr)
            Divider()
            PrayerTimeCell(salahTime: prayers?.dhuhr ?? Date(),prayer: .dhuhr)
            Divider()
            PrayerTimeCell(salahTime: prayers?.maghrib ?? Date(),prayer: .maghrib)
            Divider()
            PrayerTimeCell(salahTime: prayers?.isha ?? Date(),prayer: .isha)
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(8)
        .shadow(radius: 10)
        .padding()
    }
}

struct PrayerTimeList_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimeCard()
    }
}
