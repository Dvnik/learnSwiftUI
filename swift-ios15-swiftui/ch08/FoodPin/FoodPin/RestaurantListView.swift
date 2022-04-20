//
//  ContentView.swift
//  FoodPin
//
//  Created by Simon Ng on 21/9/2021.
//

import SwiftUI

struct RestaurantListView: View {
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
        
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    @State var restaurantIsFavorites = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    var body: some View {
        List {
            ForEach(restaurantNames.indices, id: \.self) { index in
                BasicTextImageRow(isFavorite: $restaurantIsFavorites[index], imageName: restaurantImages[index], name: restaurantNames[index], type: restaurantTypes[index], location: restaurantLocations[index])
//                FullImageRow(imageName: restaurantImages[index], name: restaurantNames[index], type: restaurantTypes[index], location: restaurantLocations[index])
            }
            
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        
    }
}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
        
        RestaurantListView()
            .preferredColorScheme(.dark)
        
        BasicTextImageRow(isFavorite: .constant(true), imageName: "cafedeadend", name: "Cafe Deadend", type: "Cafe", location: "Hong Kong")
                    .previewLayout(.sizeThatFits)

        FullImageRow(isFavorite: .constant(true), imageName: "cafedeadend", name: "Cafe Deadend", type: "Cafe", location: "Hong Kong")
            .previewLayout(.sizeThatFits)
    }
}

struct BasicTextImageRow: View {
    @State private var showOptions = false
    @State private var showError = false
    
    @Binding var isFavorite: Bool
    
    var imageName: String
    var name: String
    var type: String
    var location: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(imageName)
                .resizable()
                .frame(width: 120, height: 118)
                .cornerRadius(20)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(.title2, design: .rounded))
                
                Text(type)
                    .font(.system(.body, design: .rounded))
                
                Text(location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            if isFavorite {
                Spacer()

                Image(systemName: "heart.fill")
                    .foregroundColor(.yellow)
            }
        }
        .onTapGesture {
            showOptions.toggle()
        }
        .actionSheet(isPresented: $showOptions) {
            // 作業 #2 -移除心型圖示
            var favorTitle = "Mark as favorite"
            if isFavorite {
                favorTitle = "Remove from favorites"
            }
            
            return ActionSheet(title: Text("What do you want to do?"), message: nil, buttons: [.default(Text("Reserve a table")) {
                self.showError.toggle()
            },                       .default(Text(favorTitle)) {
                self.isFavorite.toggle()
            },                      .cancel()])
            
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Not yet available"),
                      message: Text("Sorry, this feature is not available yet. Please retry later."),
                      primaryButton: .default(Text("OK")),
                      secondaryButton: .cancel())
        }
    }
}

struct FullImageRow: View {
    //作業 #1 -對不同列佈局新增加入最愛功能
    @State private var showOptions = false
    @State private var showError = false
    
    @Binding var isFavorite: Bool

    var imageName: String
    var name: String
    var type: String
    var location: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .cornerRadius(20)

            
            
            VStack(alignment: .leading) {
                HStack {
                    Text(name)
                        .font(.system(.title2, design: .rounded))
                    
                    if isFavorite {
                        Spacer()

                        Image(systemName: "heart.fill")
                            .foregroundColor(.yellow)
                    }
                }
                

                Text(type)
                    .font(.system(.body, design: .rounded))

                Text(location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            
        }
        .onTapGesture {
            showOptions.toggle()
        }
        .actionSheet(isPresented: $showOptions) {
            ActionSheet(title: Text("What do you want to do?"), message: nil, buttons: [.default(Text("Reserve a table")) {
                self.showError.toggle()
            },                       .default(Text("Mark as favorite")) {
                self.isFavorite.toggle()
            },                      .cancel()])
            
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Not yet available"),
                      message: Text("Sorry, this feature is not available yet. Please retry later."),
                      primaryButton: .default(Text("OK")),
                      secondaryButton: .cancel())
        }
    }
}
