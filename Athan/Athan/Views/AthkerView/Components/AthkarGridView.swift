//
//  AthkarGridView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 12/09/2021.
//

import SwiftUI

struct AthkarGridView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    let offset:Double = 60;
        var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns:columns,spacing:20) {
                ForEach(0..<8) { i in
                        NavigationLink(destination:Text("\(i)")){
                            AthkarCell()
                    }
                }
                
            }//.offset(y: -offset)
        }
        .padding(Edge.Set.vertical,1)
        .padding(.horizontal)
        .background(AppColors.backgroundColor.ignoresSafeArea())
    }

    
}

struct AthkarGridView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AthkarGridView()
                .navigationBarTitle("d")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
