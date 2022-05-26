//
//  SimpleNavigationView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/25.
//

import SwiftUI

struct ArticleNavigationView: View {
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.red, .font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.red, .font: UIFont(name: "ArialRoundedMTBold", size: 20)!]

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        // 客製化標題和按鈕的交互需要注意
        // scrollEdgeAppearance沒設定好會讓Bar條無法自動消失
//        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance

        navBarAppearance.setBackIndicatorImage(UIImage(systemName: "arrow.turn.up.left"), transitionMaskImage: UIImage(systemName: "arrow.turn.up.left"))

        UINavigationBar.appearance().tintColor = .black
    }
    
    var body: some View {
        
        NavigationView {
            List(articles) { article in
                ZStack {
                    ArticleRow(article: article)
                    
                    NavigationLink(destination: ArticleDetailView(article: article, type: .navigation)) {
                        EmptyView()
                    }// end navigation link
                    .opacity(0)
                }// end ZStack
                .listRowSeparator(.hidden)
            }// end list view
            .listStyle(.plain)
            .navigationTitle("Your Reading")
        }// end navigation view

    }
}

struct SimpleNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleNavigationView()
    }
}




