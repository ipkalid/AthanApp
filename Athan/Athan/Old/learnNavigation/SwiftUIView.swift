//
//  SwiftUIView.swift
//  Athan
//
//  Created by Kalid on 07/11/2021.
//

import SwiftUI

struct SwiftUIView1: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SwiftUIView2()) {
                    Text("View1!")
                }
            }
        }
    }
}

struct SwiftUIView2: View {
    var body: some View {
        VStack {
            Text("View2!")
            Spacer()
        }
        // .navigationBarHidden(true)

        .navigationBarHidden(true)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView1()
    }
}
