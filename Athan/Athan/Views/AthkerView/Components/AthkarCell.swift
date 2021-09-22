//
//  AthkarCell.swift
//  Athan
//
//  Created by Khalid Alhazmi on 12/09/2021.
//

import SwiftUI

struct AthkarCell: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("Light Orange"), Color("Yellow")]),startPoint: .topLeading,endPoint: .bottomTrailing)
            
            Image(systemName: "seal")
                .resizable()
                .foregroundColor(.black)
                .font(.system(size: 2, weight: Font.Weight.ultraLight))
                .opacity(0.3)

            
            
            Text("أذكار الصباح")
                .font(.title2)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            
            
            
        }
        .frame(width: 100, height: 100, alignment: .center)
        .cornerRadius(16)
        //.shadow(radius: 2)
    }
}

struct AthkarCell_Previews: PreviewProvider {
    static var previews: some View {
        AthkarCell()
    }
}
