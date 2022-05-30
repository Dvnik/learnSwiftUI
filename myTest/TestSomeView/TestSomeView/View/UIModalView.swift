//
//  UIModalView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/26.
//
// sheet可以不用NavigationView也能展開

import SwiftUI

struct UIModalView: View {
//    @State var showDetailView = false
    @State var selectedArticle: Article?
    
    var body: some View {
        NavigationView {
            List(articles) { article in
                ArticleRow(article: article)
                    .onTapGesture {
                        self.selectedArticle = article
                    }

                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            // 要顯示強制回應視圖，你可應用 sheet 修飾器
//            .sheet(isPresented: $showDetailView) {
//
//                if let selectedArticle = self.selectedArticle {
//                    ArticleDetailView(article: selectedArticle)
//                }
//            }
            // 也可以改由直接由選擇值物件判斷sheet展開的條件
            .sheet(item: $selectedArticle) { article in
                ArticleDetailView(article: article, type: .sheet)
            }
            //全螢幕強制回應視圖的呈現 iOS 14 up
//            .fullScreenCover(item: $selectedArticle) { article in
//                ArticleDetailView(article: article, type: .sheet)
//            }
            .navigationBarTitle("Your Reading")
            
            // 在IPad模式下，第一個出現的View物件會自動成為側邊欄位
//            Text("Hello")
//            List {
//                Text("Hello")
//                Text("Hello")
//                Text("Hello")
//            }
        }
        //如果不需要用預設的側邊欄位分割，且希望iPad和iPhone的佈局是一致的
        //這一行就能幫助
        .navigationViewStyle(.stack)
    }
}

struct UIModalView_Previews: PreviewProvider {
    static var previews: some View {
        UIModalView()
        
        UIModalView()
            .previewDevice(.init(rawValue: "iPad Pro (12.9-inch) (5th generation)"))
    }
}
