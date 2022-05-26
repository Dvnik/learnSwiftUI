//
//  ContentView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/20.
//

import SwiftUI

struct ContentView: View {
    @State var showDetailView = true
    @State var showAlert = true
    
    var body: some View {
        Text("Hello, world!")
//            .sheet(isPresented: $showDetailView) {
//                ArticleDetailView(article: articles[0])
//            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Reminder"), message: Text("Are you sure you are finished reading the article?"), primaryButton: .default(Text("Yes"), action: { print("hello")}), secondaryButton: .cancel(Text("No")))
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
