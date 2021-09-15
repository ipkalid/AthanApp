//
//  File.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/09/2021.
//

import Foundation
import SwiftUI

struct PrayerTimeCell: View {
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                Text("Fajr")
                    .font(.title2)
                    .foregroundColor(.black)
                Text("05:45 am")
                    .font(.callout)
                    .foregroundColor(.gray)
                
            }
            Spacer()
            
            Image(systemName: "sunrise")
                .font(.largeTitle)
                .foregroundColor(.gray)
            
            
        }
        .padding(8.0)
        
    }
}

struct PrayerTimeCell_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimeCell()
    }
}
