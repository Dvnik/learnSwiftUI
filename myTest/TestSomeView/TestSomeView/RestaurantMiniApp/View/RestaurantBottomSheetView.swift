//
//  RestaurantBottomSheetView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/30.
//

import SwiftUI

struct RestaurantBottomSheetView: View {
    @State private var showDetail = false
    @State private var selectedRestaurant: Restaurant?
    
    
    var body: some View {
        ZStack {
            NavigationView {
               List {
                   ForEach(restaurants) { restaurant in
                       BasicImageRow(restaurant: restaurant)
                           .onTapGesture {
                               self.showDetail = true
                               self.selectedRestaurant = restaurant
                           }
                   }
               }
               .listStyle(.plain)
               
               .navigationBarTitle("Restaurants")
            }// end navigationview
            .offset(y: showDetail ? -100 : 0)            
            .animation(.easeOut(duration: 0.2))
            
            if showDetail {
                BlankView(bgColor: .black)
                            .opacity(0.5)
                            .onTapGesture {
                                self.showDetail = false
                            }
                if let selectedRestaurant = selectedRestaurant {
                    RestaurantSheetDetailView(restaurant: selectedRestaurant, isShow: $showDetail)
                    
                }
            }
            
        }
    }// end body
}

struct RestaurantBottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantBottomSheetView()
    }
}


struct BasicImageRow: View {
    var restaurant: Restaurant
    
    var body: some View {
        HStack {
            Image(restaurant.image)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(5)
            Text(restaurant.name)
        }
    }
}

