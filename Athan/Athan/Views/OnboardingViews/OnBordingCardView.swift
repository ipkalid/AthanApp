//
//  onBordingCardView.swift
//  Athan
//
//  Created by Kalid on 08/11/2021.
//

import SwiftUI

struct OnBordingCardView<Icon: View>: View {
    init(title: LocalizedStringKey, frameSize: Double = 70, @ViewBuilder icon: () -> Icon, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon()
        self.frameSize = frameSize
        self.action = action
    }

    let title: LocalizedStringKey
    let icon: Icon
    let frameSize: Double
    let action: () -> Void

    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .multilineTextAlignment(.center)

            Button(action: action) {
                icon
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: frameSize, height: frameSize, alignment: .center)
                    .background(
                        Circle()
                            .stroke(.black, lineWidth: 2)
                    )
            }
        }
        .font(.largeTitle)
        .modifier(MainCardStyle(height: 300))
        .padding()
    }
}
