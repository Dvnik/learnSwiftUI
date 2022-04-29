//
//  ContentView.swift
//  SwiftUIScrollView
//
//  Created by Trixie Lulamoon on 2022/4/29.
//

import SwiftUI

struct ContentView: View {
    

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {

                // 作業#1的程式碼
                // Home work
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("MONDAY, AUG, 20")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text("Your Reading")
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundColor(.primary)
                                .lineLimit(3)
                                .minimumScaleFactor(0.5)
                            
                        }

                        Spacer()
                    }
                }
                .padding()
                
                HStack {
                    Group {
                        CardView(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners", author: "Simon Ng")
                        CardView(image: "macos-programming", category: "macOS", heading: "Building a Simple Editing App", author: "Gabriel Theodoropoulos")
                        CardView(image: "flutter-app", category: "Flutter", heading: "Building a Complex Layout with Flutter", author: "Lawrence Tan")
                        CardView(image: "natural-language-api", category: "iOS", heading: "What's New in Natural Language API", author: "Sai Kambampati")
                    }
                    .frame(width: 300)
                }
            }
            //Home work 2
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
