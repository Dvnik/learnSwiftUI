//
//  ArticleRow.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/26.
//

import SwiftUI
// 這是在List的每個元件所展示的簡易資訊
struct ArticleRow: View {
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(article.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
            
            Text(article.title)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .lineLimit(3)
                .padding(.bottom, 0)
            
            Text("By \(article.author)".uppercased())
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 0)
            
            HStack(spacing: 3) {
                ForEach(1...(article.rating), id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                }
            }
            
            Text(article.excerpt)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
        }
    }
}



struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow(article: articles[0])
            .previewLayout(.fixed(width: 300, height: 600))
    }
}
