//
//  ArticleDetailView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/25.
//

import SwiftUI

struct ArticleDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert = false
    
    var article: Article
    var type: ArticleDetailType = .normal
    /**
     因為範例上後來都是對ScrollView包上sheet或是navigation，
     所以分出來「共同的部分」與「差異的部分」。
     再用enum動態選取
     */
    
    var detail01:some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(article.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                Group {
                    Text(article.title)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.black)
                        .lineLimit(3)

                    Text("By \(article.author)".uppercased())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 0)
                .padding(.horizontal)

                Text(article.content)
                    .font(.body)
                    .padding()
                    .lineLimit(1000)
                    .multilineTextAlignment(.leading)
            }
        }
    }
    /**
     和Toolbar的自定義按鈕不同的地方是，Toolbar是取代NavigationView的預設佈局。
     而overlay是上疊一個View。
     */
    var detail02:some View {
        detail01
//            .navigationBarHidden(true)// 隱藏整條Bar
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)//隱藏返回按鈕
            .ignoresSafeArea(.all, edges: .top)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {

                    Button(action: {
                        // 導覽至前一個畫面
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
            }
            
    }
    
    var detail03:some View {
        detail01
            .ignoresSafeArea(.all, edges: .top)
            .overlay(

                HStack {
                    Spacer()

                    VStack {
                        Button(action: {
    //                        dismiss()
                            self.showAlert = true
                        }, label: {
                            Image(systemName: "chevron.down.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        })
                        .padding(.trailing, 20)
                        .padding(.top, 40)

                        Spacer()
                    }
                }
            )
            // alert也可以長在一般的View上使用
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Reminder"), message: Text("Are you sure you are finished reading the article?"), primaryButton: .default(Text("Yes"), action: { dismiss() }), secondaryButton: .cancel(Text("No")))
            }
    }
    
    var body: some View {
        switch type {
        case .normal:
            detail01
        case .navigation:
            detail02
        case .sheet:
            detail03
        }
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ArticleDetailView(article: articles[0], type: .navigation)
        }
        
    }
}


enum ArticleDetailType {
    case normal
    case navigation
    case sheet
}
