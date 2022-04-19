//
//  ContentView.swift
//  homework02
//
//  Created by Trixie Lulamoon on 2022/4/19.
//

import SwiftUI

struct ContentView: View {
    // 因為題目的圖面名稱和restaurantNames陣列的名稱一致，
    // 才能夠直接使用字串套在Image上
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var body: some View {
        List(restaurantNames, id: \.self) { restaurantName in
            HStack {
                Image(restaurantName)
                    .resizable()
                    .frame(width: 40, height: 40)

                Text(restaurantName)
            }
        }
        .listStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
