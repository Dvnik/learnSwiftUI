//
//  RestaurantDetailView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/26.
//

import Foundation
import SwiftUI

struct RestaurantDetailView: View {
    @Environment(\.dismiss) var dismiss

    var restaurant: Restaurant

    var body: some View {
        VStack {
            Image(restaurant.image)
                .resizable()
                .aspectRatio(contentMode: .fit)

            Text(restaurant.name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)

            Spacer()
        }

        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            dismiss()
        }){
            Text("\(Image(systemName: "chevron.left")) \(restaurant.name)")
                .foregroundColor(.black)
        })
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RestaurantDetailView(restaurant: Restaurant(name: "CASK Pub and Kitchen", image: "caskpubkitchen"))
        }
    }
}
