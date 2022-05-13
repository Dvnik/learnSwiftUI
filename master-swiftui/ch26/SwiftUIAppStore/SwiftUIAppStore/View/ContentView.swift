//
//  ContentView.swift
//  SwiftUIAppStore
//
//  Created by Simon Ng on 17/12/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var showContents: [Bool] = Array(repeating: false, count: sampleArticles.count)
    
    enum ContentMode {
        case list
        case content
    }

    private var contentMode: ContentMode {
        self.showContents.contains(true) ? .content : .list
    }

    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                VStack(spacing: 40) {

                    TopBarView()
                        .padding(.horizontal, 20)

                    ForEach(sampleArticles.indices) { index in
                        GeometryReader { inner in
                            ArticleCardView(category: sampleArticles[index].category, headline: sampleArticles[index].headline, subHeadline: sampleArticles[index].subHeadline, image: sampleArticles[index].image, content: sampleArticles[index].content, isShowContent: self.$showContents[index])

                                .padding(.horizontal, 20)
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(response: 0.55, dampingFraction: 0.65, blendDuration: 0.1)) {
                                        self.showContents[index] = true
                                    }
                                }

                                .offset(y: self.showContents[index] ? -inner.frame(in: .global).minY : 0)

                        }
                        .frame(height: self.showContents[index] ? fullView.size.height + fullView.safeAreaInsets.top + fullView.safeAreaInsets.bottom : min(sampleArticles[index].image.size.height/3, 500))
                        
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct TopBarView : View {

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            VStack(alignment: .leading) {
                Text(getCurrentDate().uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("Today")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }

            Spacer()

            AvatarView(image: "profile", width: 40, height: 40)

        }
    }

    func getCurrentDate(with format: String = "EEEE, MMM d") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }
}

struct AvatarView: View {
    let image: String
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        Image(image)
            .resizable()
            .frame(width: width, height: height)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
    }
}
