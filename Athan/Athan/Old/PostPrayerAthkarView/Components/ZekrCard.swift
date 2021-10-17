//
//  ZekrCardView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/10/2021.
//

import Foundation
import SwiftUI

struct ZekrCardView: View {
    @State var zekrContent: ZekrContent
    var onTap: () -> Void
    init(zekrContent: ZekrContent, onTap: @escaping () -> Void) {
        self.zekrContent = zekrContent
        self.onTap = onTap
    }

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text(zekrContent.zekr)
                .font(Font.custom("me_quran", size: 42))
                .minimumScaleFactor(0.1)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 4)
            Spacer()
            Text(zekrContent.bless)
                .font(.system(size: 14))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            (zekrContent.contentRepeat != 0)
                ? AnyView(
                    Text("\(zekrContent.contentRepeat)")
                        .font(.system(size: 21, weight: .medium))
                        .minimumScaleFactor(0.5)
                        .padding(.all, 4)
                        .frame(width: 27, height: 27, alignment: .center)
                        .background(
                            Circle()
                                .stroke(.black, lineWidth: 1)
                        )
                )
                : AnyView(
                    Text(Image(systemName: "checkmark.seal"))
                        .fontWeight(.medium)
                        .font(.system(size: 21))
                        .foregroundColor(.green)
                        .frame(width: 27, height: 27, alignment: .center)
                )
        }
        .frame(width: UIScreen.screenWidth * 0.8, height: 300)
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(8)
        .onTapGesture {
            if zekrContent.contentRepeat > 0 {
                zekrContent.contentRepeat = zekrContent.contentRepeat - 1

                UINotificationFeedbackGenerator().notificationOccurred(.warning)

                if zekrContent.contentRepeat == 0 {
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                    onTap()
                }
            }
        }
        .shadow(radius: 10)
    }
}

struct ZekrCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZekrCardView(zekrContent: ZekrContent(zekr: "السلام عليكم", contentRepeat: 1, bless: "السلام عليمم"), onTap: { print("dd") })
    }
}
