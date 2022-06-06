//
//  StorePageMainView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/6/6.
//

import SwiftUI

struct StorePageMainView: View {
    
    enum ContentMode {
        case list
        case content
    }
    
    @State private var showContents: [Bool] = Array(repeating: false, count: sampleArticles.count)
    
    private var contentMode: ContentMode {
        self.showContents.contains(true) ? .content : .list
    }
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                VStack(spacing: 40) {
                    StorePageTopView()
                        .padding(.horizontal, 20)
                        .opacity(self.contentMode == .content ? 0 : 1)
                    
                    ForEach(sampleArticles.indices) { index in
                        GeometryReader { inner in
                            let sampleArticle = sampleArticles[index]
                            
                            StoreArticleCardView(
                                category: sampleArticle.category,
                                headline: sampleArticle.headline,
                                subHeadline: sampleArticle.subHeadline,
                                image: sampleArticle.image,
                                content: sampleArticle.content,
                                isShowContent: self.$showContents[index])
                            // 找出卡片視圖的上邊緣與螢幕之間的距離:
                            // inner.frame(in: .global).minY)
                            .offset(y: self.showContents[index] ? -inner.frame(in: .global).minY : 0)
                            .padding(.horizontal, self.showContents[index] ? 0 : 20)
                            .opacity(
                                self.contentMode == .list ||
                                self.contentMode == .content && self.showContents[index] ? 1 : 0
                            )
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.55, dampingFraction: 0.65, blendDuration: 0.1)) {
                                       self.showContents[index] = true
                                }
                            }
                        }//end GeometryReader
                        .frame(height: self.showContents[index] ? fullView.size.height + fullView.safeAreaInsets.top + fullView.safeAreaInsets.bottom : min(sampleArticles[index].image.size.height/3, 500))
                    }// end ForEach
                    
                }
            }//end scrollview
        }//end GeometryReader
    }
}

struct StorePageMainView_Previews: PreviewProvider {
    static var previews: some View {
        StorePageMainView()
    }
}

struct StorePageTopView: View {
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            VStack(alignment: .leading) {
                Text(getCurrentDate().uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("Today")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }//end vstack
            Spacer()
            
            StoreAvatarView(image: "profile", width: 40, height: 40)
            
        }//end hstack
    }
    
    
    func getCurrentDate(with format: String = "EEEE, MMM d") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: Date())
    }
    
    
    
}


struct StoreAvatarView: View {
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
