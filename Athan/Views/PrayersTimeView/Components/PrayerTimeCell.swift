//
//  File.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/09/2021.
//

import Adhan
import Foundation
import SwiftUI

struct PrayerTimeCell: View {
    @EnvironmentObject var env: EnvViewModel
    let prayer: Adhan.Prayer

    let salahTime: Date
    init(salahTime: Date = Date(), prayer: Adhan.Prayer = .fajr) {
        self.salahTime = salahTime
        self.prayer = prayer
    }

    var isNextPrayer: Bool {
        if let nextPrayer = env.prayers?.nextPrayer() {
            return prayer.prayerName == nextPrayer.prayerName
        }

        return false
    }

    // to get the prayer name

    var body: some View {
        var topPdaaing: Double = 8.0
        var buttonPadding: Double = 8.0
        switch prayer {
        case .fajr:
            topPdaaing = 10.0
        case .isha:
            buttonPadding = 10.0
        default:
            topPdaaing = 5.0
            buttonPadding = 5.0
        }
        return HStack {
            VStack(alignment: .leading) {
                Text(prayer.prayerName)
                    .font(.title2.weight(isNextPrayer ? .bold : .regular))
                    .foregroundColor(.black)

                Text(salahTime.getShortDate())
                    .font(.callout.weight(isNextPrayer ? .bold : .regular))
                    .foregroundColor(.gray)
            }
            .scaleEffect(isNextPrayer ? 1.1 : 1)

            Spacer()

            Image(systemName: prayer.prayerIcon)
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(.gray, .orange)
                .font(.largeTitle)
                .scaleEffect(isNextPrayer ? 1.1 : 1)
//                .foregroundColor(.gray)
        }
        .padding(.horizontal, 8.0)
        .padding(.top, topPdaaing)
        .padding(.bottom, buttonPadding)
        .padding(.horizontal)
        .background(isNextPrayer ? AppColors.yellow.opacity(0.3) : nil)
    }
}
