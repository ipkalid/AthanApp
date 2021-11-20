//
//  File.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/09/2021.
//

import Foundation
import SwiftUI

struct PrayerTimeCell: View {
    let prayer: Prayer

    let salahTime: Date
    init(salahTime: Date = Date(), prayer: Prayer = .fajr) {
        self.salahTime = salahTime
        self.prayer = prayer
    }

    // to get the prayer name

    private var prayerName: LocalizedStringKey {
        switch prayer {
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

    // to get the prayer icon
    private var prayerIcon: String {
        switch prayer {
        case .fajr:
            return "sun.and.horizon"
        case .sunrise:
            return "sunrise"
        case .dhuhr:
            return "sun.max"
        case .asr:
            return "cloud.sun"
        case .maghrib:
            return "sunset"
        case .isha:
            return "moon.stars"
        }
    }

    var body: some View {
        var topPdaaing: Double = 8.0
        var buttonPadding: Double = 8.0
        switch prayer {
        case .fajr:
            topPdaaing = 0.0
        case .isha:
            buttonPadding = 0.0
        default:
            topPdaaing = 6.0
            buttonPadding = 6.0
        }
        return HStack {
            VStack(alignment: .leading) {
                Text(prayerName)
                    .font(.title2)
                    .foregroundColor(.black)
                Text(salahTime.getShortDate())
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            Spacer()

            Image(systemName: prayerIcon)
                .font(.largeTitle)
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 8.0)
        .padding(.top, topPdaaing)
        .padding(.bottom, buttonPadding)
    }
}

struct PrayerTimeCell_Previews: PreviewProvider {
    static var previews: some View {
        //   let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let startDate = Date()
        return PrayerTimeCell(salahTime: startDate)
    }
}
