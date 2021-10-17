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

    let salahTime: Date?
    init(salahTime: Date = Date(), prayer: Prayer = .fajr) {
        self.salahTime = salahTime
        self.prayer = prayer
    }

    // to get the prayer name
    private var prayerName: String {
        switch prayer {
        case .fajr:
            return "Fajr"
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
            return "sunrise"
        case .dhuhr:
            return "sun.min"
        case .asr:
            return "cloud.sun"
        case .maghrib:
            return "sunset"
        case .isha:
            return "moon.stars"
        }
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(prayerName)
                    .font(.title2)
                    .foregroundColor(.black)
                Text(salahTime?.getShortDate() ?? " - ")
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            Spacer()

            Image(systemName: prayerIcon)
                .font(.largeTitle)
                .foregroundColor(.gray)
        }
        .padding(8.0)
    }
}

struct PrayerTimeCell_Previews: PreviewProvider {
    static var previews: some View {
        //   let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let startDate = Date()
        return PrayerTimeCell(salahTime: startDate)
    }
}
