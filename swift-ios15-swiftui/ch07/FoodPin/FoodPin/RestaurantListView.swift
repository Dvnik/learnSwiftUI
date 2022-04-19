//
//  ContentView.swift
//  FoodPin
//
//  Created by Trixie Lulamoon on 2022/4/19.
//

import SwiftUI

struct RestaurantListView: View {
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    
    var body: some View {
        List {
            ForEach(restaurantNames.indices, id: \.self) { index in
                
                HStack(alignment: .top, spacing: 20) {
                    Image(restaurantImages[index])
                        .resizable()
                        .frame(width: 120, height: 118)
                        .cornerRadius(20)
                    
                    VStack(alignment: .leading) {
                        Text(restaurantNames[index])
                            .font(.system(.title2, design: .rounded))
                        Text("Type")
                            .font(.system(.body, design: .rounded))

                        Text("Location")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(.gray)
                    }
                }
                
                
            }
            // 可以加上 listRowSeparator 修飾器及設定值為 .hidden 來隱藏分隔線
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
        
//        RestaurantListView()
//            .preferredColorScheme(.dark)
    }
}
