import Foundation
import SwiftUI

struct ZekrCardView: View {
    @State var zekrContent: ZekrContent
    var onTap: () -> Void
    init(zekrContent: ZekrContent, onTap: @escaping () -> Void) {
        self.zekrContent = zekrContent
        self.onTap = onTap
    }

    func buttonAction() {
        if zekrContent.contentRepeat >= 0 {
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
            if zekrContent.contentRepeat == 0 {
                onTap()
                return
            }
            zekrContent.contentRepeat = zekrContent.contentRepeat - 1

            if zekrContent.contentRepeat == 0 {
                onTap()
            }
        }
    }

    var body: some View {
        Button(action: buttonAction) {
            VStack(alignment: .center) {
                Spacer()
                Text(zekrContent.zekr)
                    .font(Font.custom("me_quran", size: 42))
                    .minimumScaleFactor(0.1)
                    .padding(.horizontal, 4)
                Spacer()
                Text(zekrContent.bless)
                    .font(.system(size: 14))

                if zekrContent.contentRepeat != 0 {
                    Text("\(zekrContent.contentRepeat)")
                        .font(.system(size: 21, weight: .medium))
                        .minimumScaleFactor(0.5)
                        .padding(.all, 4)
                        .frame(width: 27, height: 27, alignment: .center)
                        .background(
                            Circle()
                                .stroke(.black, lineWidth: 1)
                        )
                } else {
                    Text(Image(systemName: "checkmark.seal"))
                        .fontWeight(.medium)
                        .font(.system(size: 21))
                        .foregroundColor(.green)
                        .frame(width: 27, height: 27, alignment: .center)
                }
            }
            .multilineTextAlignment(.center)
            .modifier(MainCardStyle(height: 300))
        }
        .buttonStyle(.plain)
    }
}

