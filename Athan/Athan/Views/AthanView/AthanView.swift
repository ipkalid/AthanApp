//
//  AthanView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 12/09/2021.
//

import SwiftUI

struct AthanView: View {
    var body: some View {
        NavigationView{
            PrayerItmeView()
                .navigationBarTitle("الرياض.")
                .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct AthanView_Previews: PreviewProvider {
    static var previews: some View {
        AthanView()
    }
}
