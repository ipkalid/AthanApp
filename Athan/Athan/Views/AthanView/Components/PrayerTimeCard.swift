//
//  PrayerTimeList.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/09/2021.
//

import Foundation

import SwiftUI

struct PrayerTimeCard: View {
    var body: some View {
        VStack(spacing:0){
            PrayerTimeCell()
            Divider()
            PrayerTimeCell()
            Divider()
            PrayerTimeCell()
            Divider()
            PrayerTimeCell()
            Divider()
            PrayerTimeCell()
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
