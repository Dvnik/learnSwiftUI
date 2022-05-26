//
//  RestaurantNavigationView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/26.
//

import SwiftUI

struct RestaurantNavigationView: View {
    // Custom Bar Title by UINavigationBar
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.red, .font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.red, .font: UIFont(name: "ArialRoundedMTBold", size: 20)!]

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        // 客製化標題和按鈕的交互需要注意
        // scrollEdgeAppearance沒設定好會讓Bar條無法自動消失
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance

        navBarAppearance.setBackIndicatorImage(UIImage(systemName: "arrow.turn.up.left"), transitionMaskImage: UIImage(systemName: "arrow.turn.up.left"))

        UINavigationBar.appearance().tintColor = .black
    }
    
    
    var restaurants = [ Restaurant(name: "Cafe Deadend", image: "cafedeadend"),
               Restaurant(name: "Homei", image: "homei"),
               Restaurant(name: "Teakha", image: "teakha"),
               Restaurant(name: "Cafe Loisl", image: "cafeloisl"),
               Restaurant(name: "Petite Oyster", image: "petiteoyster"),
               Restaurant(name: "For Kee Restaurant", image: "forkeerestaurant"),
               Restaurant(name: "Po's Atelier", image: "posatelier"),
               Restaurant(name: "Bourke Street Bakery", image: "bourkestreetbakery"),
               Restaurant(name: "Haigh's Chocolate", image: "haighschocolate"),
               Restaurant(name: "Palomino Espresso", image: "palominoespresso"),
               Restaurant(name: "Upstate", image: "upstate"),
               Restaurant(name: "Traif", image: "traif"),
               Restaurant(name: "Graham Avenue Meats And Deli", image: "grahamavenuemeats"),
               Restaurant(name: "Waffle & Wolf", image: "wafflewolf"),
               Restaurant(name: "Five Leaves", image: "fiveleaves"),
               Restaurant(name: "Cafe Lore", image: "cafelore"),
               Restaurant(name: "Confessional", image: "confessional"),
               Restaurant(name: "Barrafina", image: "barrafina"),
               Restaurant(name: "Donostia", image: "donostia"),
               Restaurant(name: "Royal Oak", image: "royaloak"),
               Restaurant(name: "CASK Pub and Kitchen", image: "caskpubkitchen")
]
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(restaurants) { restaurant in
                    NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                        BasicImageRow(restaurant: restaurant)
                    }
                }// end ForEach
            }// end list view
            .listStyle(.plain)
            .navigationBarTitle("Restaurants", displayMode: .inline)
//            .navigationBarTitle("Restaurants", displayMode: .automatic)
            .navigationBarBackButtonHidden(true)
        }// end navigation view
    }
}

struct RestaurantNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantNavigationView()
    }
}
