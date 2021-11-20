//
//  timer.swift
//  Athan
//
//  Created by Kalid on 20/11/2021.
//

import Foundation
import SwiftUI
struct CountDownView: View {
    @State var nowDate: Date = Date()
    let referenceDate: Date = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text(countDownString(from: referenceDate))
            .font(.largeTitle)
            .onReceive(timer, perform: { _ in
                nowDate = Date()
            })
          
    }

    func countDownString(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar
            .dateComponents([.day, .hour, .minute, .second],
                            from: nowDate,
                            to: referenceDate)
        return String(format: "%02dd:%02dh:%02dm:%02ds",
                      components.day ?? 00,
                      components.hour ?? 00,
                      components.minute ?? 00,
                      components.second ?? 00)
    }
}
