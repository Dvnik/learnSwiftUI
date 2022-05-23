//
//  ScrollCardView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/23.
//
//  來源：master SwiftUI ch05 by AppCoda

import SwiftUI

struct ScrollCardView: View {
    var image: String
    var category: String
    var heading: String
    var author: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(category)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(heading)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                    Text("Written by \(author)".uppercased())
                        .font(.caption)
                    
                }
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                .padding([.top, .horizontal])
        }
    }
}

struct ScrollCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollCardView(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners", author: "Simon Ng")
            .previewLayout(.fixed(width: 300, height: 600))
        
        ScrollCardExampleView()
    }
}

struct ScrollCardExampleView: View {
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("MONDAY, AUG 20")
                            .font(.system(.caption, design: .rounded))
                            .fontWeight(.thin)
                        Text("Your Reading")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.black)
                    }
                    Spacer()
                }
                .padding()
                
                HStack {
                    Group {
                        ScrollCardView(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners", author: "Simon Ng")
                        ScrollCardView(image: "macos-programming", category: "macOS", heading: "Building a Simple Editing App", author: "Gabriel Theodoropoulos")
                        ScrollCardView(image: "flutter-app", category: "Flutter", heading: "Building a Complex Layout with Flutter", author: "Lawrence Tan")
                        ScrollCardView(image: "natural-language-api", category: "iOS", heading: "What's New in Natural Language API", author: "Sai Kambampati")
                    }
                    .frame(width: 300)
                   
                }
                
            }
            Spacer()
        }
        
    }
}
