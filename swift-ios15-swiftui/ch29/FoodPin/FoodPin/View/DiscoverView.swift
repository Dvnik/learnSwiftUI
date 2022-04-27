//
//  DiscoverView.swift
//  FoodPin
//
//  Created by Simon Ng on 11/10/2021.
//

import SwiftUI
import CloudKit

struct DiscoverView: View {
    @StateObject private var cloudStore: RestaurantCloudStore = RestaurantCloudStore()
    
    @State private var showLoadingIndicator = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List(cloudStore.restaurants, id: \.recordID) { restaurant in
                    VStack(alignment: .leading) {
                        AsyncImage(url: getImageURL(restaurant: restaurant)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.purple.opacity(0.1)
                        }
                        .frame(height: 200)
                        .cornerRadius(30)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(restaurant.object(forKey: "name") as! String)
                                .font(.title2)
                                
                            Text(restaurant.object(forKey: "location") as! String)
                                .font(.headline)
                            
                            Text(restaurant.object(forKey: "type") as! String)
                                .font(.subheadline)
                            
                            Text(restaurant.object(forKey: "description") as! String)
                                .font(.subheadline)
                        }
                        .padding(10)
                    }
                    
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .task {
                    cloudStore.fetchRestaurantsWithOperational {
                        showLoadingIndicator = false
                    }
                }
                .onAppear() {
                    showLoadingIndicator = true
                }
                .refreshable {
                    cloudStore.fetchRestaurantsWithOperational {
                        showLoadingIndicator = false
                    }
                }
                
                if showLoadingIndicator {
                    ProgressView()
                }

            }
            
            .navigationTitle(String(localized: "Discover"))
            .navigationBarTitleDisplayMode(.automatic)
            
        }
    }
    
    private func getImageURL(restaurant: CKRecord) -> URL? {
        guard let image = restaurant.object(forKey: "image"),
              let imageAsset = image as? CKAsset else {
            return nil
        }
        
        return imageAsset.fileURL
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
