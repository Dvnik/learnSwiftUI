//
//  AboutView.swift
//  FoodPin
//
//  Created by Trixie Lulamoon on 2022/4/26.
//

import SwiftUI

struct AboutView: View {
    @State private var link: WebLink?
    
    enum WebLink: String, Identifiable {
        case rateUs = "https://www.apple.com/ios/app-store"
        case feedback = "https://www.appcoda.com/contact"
        case twitter = "https://www.twitter.com/appcodamobile"
        case facebook = "https://www.facebook.com/appcodamobile"
        case instagram = "https://www.instagram.com/appcodadotcom"

        var id: UUID {
            UUID()
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Image("about")
                    .resizable()
                    .scaledToFit()

                Section {
                    Link(destination: URL(string: WebLink.rateUs.rawValue)!, label: {
                        Label("Rate us on App Store", image: "store")
                            .foregroundColor(.primary)
                    })

                    Label("Tell us your feedback", image: "chat")
                        .onTapGesture {
                            link = .feedback
                        }
                }

                Section {
                    Label("Twitter", image: "twitter")
                        .onTapGesture {
                            link = .twitter
                        }

                    Label("Facebook", image: "facebook")
                        .onTapGesture {
                            link = .facebook
                        }

                    Label("Instagram", image: "instagram")
                        .onTapGesture {
                            link = .instagram
                        }
                }
            }
            .listStyle(GroupedListStyle())
            .sheet(item: $link) { item in
                if let url = URL(string: item.rawValue) {
                    SafariView(url: url)
                }
            }
            
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.automatic)
            
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
