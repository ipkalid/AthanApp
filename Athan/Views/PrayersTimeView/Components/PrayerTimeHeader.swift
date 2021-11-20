//
//  PrayerTimeHeader.swift
//  Athan
//
//  Created by Khalid Alhazmi on 12/09/2021.
//

import SwiftUI

struct PrayerTimeHeader: View {
    var body: some View {
        HStack(alignment: .center) {
            Text(higriDate())
                .frame(width: 100)
                .padding(.vertical, 8)
                .background(.white.opacity(0.5))
                .cornerRadius(20)

            Spacer()

            Text(dayInWeek())
                .font(.title2)
                .font(.system(.title2, design: .monospaced))
                .fontWeight(.bold)
                .minimumScaleFactor(0.4)
                .foregroundColor(AppColors.yellow)
                .shadow(radius: 6)

            Spacer()

            Text(getDate())
                .frame(width: 100)
                .padding(.vertical, 8)
                .background(.white.opacity(0.5))
                .cornerRadius(20)
        }
        .padding(.horizontal, 32)
        .padding(.top, 5)
    }

    private func higriDate() -> String {
        let dateFormatter = DateFormatter()

        let hijriCalendar = Calendar(identifier: Calendar.Identifier.islamicUmmAlQura)
        dateFormatter.locale = Locale(identifier: "ar")
        dateFormatter.calendar = hijriCalendar
        dateFormatter.dateFormat = "YYYY/MM/dd"

        return dateFormatter.string(from: Date.now)
    }

    private func dayInWeek() -> String {
        let dateFormatter = DateFormatter()
        if Helper.isArabic() {
            dateFormatter.dateFormat = "EEEE"
        } else {
            dateFormatter.dateFormat = "EE"
        }

        return dateFormatter.string(from: Date.now)
    }

    private func getDate() -> String {
        let dateFormatter = DateFormatter()

        let gregorianCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.calendar = gregorianCalendar
        dateFormatter.dateFormat = "YYYY/MM/dd"
        return dateFormatter.string(from: Date.now)
    }
}

extension PrayerTimeHeader {}
