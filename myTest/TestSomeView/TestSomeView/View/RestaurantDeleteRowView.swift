//
//  RestaurantDeleteRowView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/27.
//

import SwiftUI

struct RestaurantDeleteRowView: View {
    @State private var showActionSheet = false

    @State private var selectedRestaurant: Restaurant?
    
    @State var restaurants = [ Restaurant(name: "Cafe Deadend", image: "cafedeadend"),
                   Restaurant(name: "Homei", image: "homei"),
                   Restaurant(name: "Teakha", image: "teakha"),
                   Restaurant(name: "Cafe Loisl", image: "cafeloisl"),
                   Restaurant(name: "Petite Oyster", image: "petiteoyster"),
                   Restaurant(name: "For Kee Restaurant", image: "forkeerestaurant"),
                   Restaurant(name: "Po's Atelier", image: "posatelier"),
                   Restaurant(name: "Bourke Street Bakery", image: "bourkestreetbakery"),
                   Restaurant(name: "Haigh's Chocolate", image: "haighschocolate"),
                   Restaurant(name: "Palomino Espresso", image: "palominoespresso"),
                   Restaurant(name: "Homei", image: "upstate"),
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
        List {
            ForEach(restaurants) { restaurant in
                BasicImageRow(restaurant: restaurant)
                    .contextMenu {
                        Button(action: {
                            self.delete(item: restaurant)
                        }) {
                            HStack {
                                Text("Check-in")
                                Image(systemName: "checkmark.seal.fill")
                            }
                        }
                        Button(action: {
                            self.delete(item: restaurant)
                        }) {
                            HStack {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                        }
                        
                        Button(action: {
                            // 將所選的餐廳標記為最愛
                            self.setFavorite(item: restaurant)
                        }) {
                            HStack {
                                Text("Favorite")
                                Image(systemName: "star")
                            }
                        }
                    }// end .contextMenu
                    .onTapGesture {
                        self.showActionSheet.toggle()
                        self.selectedRestaurant = restaurant
                    }// end .onTapGesture
                    .actionSheet(isPresented: self.$showActionSheet) {
                        ActionSheet(title: Text("What do you want to do"), message: nil, buttons: [

                            .default(Text("Mark as Favorite"), action: {
                                if let selectedRestaurant = self.selectedRestaurant {
                                    self.setFavorite(item: selectedRestaurant)
                                }
                            }),

                            .destructive(Text("Delete"), action: {
                                if let selectedRestaurant = self.selectedRestaurant {
                                    self.delete(item: selectedRestaurant)
                                }
                            }),

                            .cancel()
                        ])
                        
                        
                    }// end .actionSheet
            }
            .onDelete { (indexSet) in
                self.restaurants.remove(atOffsets: indexSet)
            }
        }
        .listStyle(.plain)
    }
    
    private func delete(item restaurant: Restaurant) {
        if let index = self.restaurants.firstIndex(where: { $0.id == restaurant.id }) {
            self.restaurants.remove(at: index)
        }
    }
    
    private func setFavorite(item restaurant: Restaurant) {
        if let index = self.restaurants.firstIndex(where: { $0.id == restaurant.id }) {
            self.restaurants[index].isFavorite.toggle()
        }
    }
}

struct RestaurantDeleteRowView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDeleteRowView()
    }
}
