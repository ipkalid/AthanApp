//
//  onBordingCardView.swift
//  Athan
//
//  Created by Kalid on 08/11/2021.
//

import SwiftUI

struct OnBordingCardView<IconButtom: View>: View {
    init(title: LocalizedStringKey, frameSize: Double = 70, @ViewBuilder iconButtom: () -> IconButtom) {
        self.title = title
        iconButton = iconButtom()
        self.frameSize = frameSize
    }

    let title: LocalizedStringKey
    let iconButton: IconButtom
    let frameSize: Double

    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .multilineTextAlignment(.center)

            iconButton
                .foregroundColor(.black)
                .padding()
                .frame(width: frameSize, height: frameSize, alignment: .center)
                .background(
                    Circle()
                        .stroke(.black, lineWidth: 2)
                )
        }
        .font(.largeTitle)
        .modifier(MainCardStyle(height: 300))
        .padding()
    }
}
