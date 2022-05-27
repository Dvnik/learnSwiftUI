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
    
    @State var toggleTest = false
    @State private var showActionSheet = false
    
    var body: some View {
        
        VStack {
            Text("Hello, world!")
    //            .sheet(isPresented: $showDetailView) {
    //                ArticleDetailView(article: articles[0])
    //            }
//                .alert(isPresented: $showAlert) {
//                    Alert(title: Text("Reminder"), message: Text("Are you sure you are finished reading the article?"), primaryButton: .default(Text("Yes"), action: { print("hello")}), secondaryButton: .cancel(Text("No")))
//                }
            
            
            Section(header: Text("FILTER PREFERENCE")) {
                Toggle(isOn: $toggleTest) {
                    Text("Show Check-in Only")
                }// end toggle
                Toggle(isOn: $toggleTest) {
                    Text("Show Check-in Only")
                }// end toggle
            }
            .contextMenu{
                Button {
                    //
                } label: {
                    Text("TextClick")
                }

            }
            .actionSheet(isPresented: self.$showActionSheet) {
                ActionSheet(title: Text("What do you want to do"), message: nil, buttons: [

                    .default(Text("Mark as Favorite"), action: {
                        print("favorite")
                    }),

                    .destructive(Text("Delete"), action: {
                        print("Delete")
                    }),

                    .cancel()
                ])
                
                
            }// end .actionSheet
            .onTapGesture {
                self.showActionSheet.toggle()
            }// end .onTapGesture
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
