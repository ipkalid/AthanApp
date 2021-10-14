//
//  ZekrCardView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/10/2021.
//

import Foundation
import SwiftUI

struct ZekrCardView: View {
    @State var zekrContent:ZekrContent
    var onTap:()-> Void    
    init(zekrContent:ZekrContent,onTap: @escaping ()-> Void){
        self.zekrContent = zekrContent
        self.onTap = onTap
       
    }
   
    var body: some View {
        VStack(alignment:.center){
            Spacer()
            Text(zekrContent.zekr)
                .font(Font.custom("me_quran", size: 42))
                .minimumScaleFactor(0.1)
                .multilineTextAlignment(.center)
                .padding(.horizontal,4)
            Spacer()
            Text(zekrContent.bless)
                .foregroundColor(.black)
                .font(.caption)
                .multilineTextAlignment(.center)
            (zekrContent.contentRepeat != 0)
            ? Text("\((zekrContent.contentRepeat))")
                .font(Font.title2)
                .fontWeight(.bold)
            : Text(Image(systemName: "checkmark.seal"))
                .font(Font.title2)
                .fontWeight(.medium)
                .foregroundColor(.green)
        }
        .frame(width: UIScreen.screenWidth * 0.8, height:300)
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(8)
        .onTapGesture() {
            if(zekrContent.contentRepeat > 0){
                
                zekrContent.contentRepeat = zekrContent.contentRepeat - 1
                
                
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                
                if(zekrContent.contentRepeat == 0){
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                    onTap()
                }
                
            }
            
        }
        .shadow(radius: 10)

    }
}
