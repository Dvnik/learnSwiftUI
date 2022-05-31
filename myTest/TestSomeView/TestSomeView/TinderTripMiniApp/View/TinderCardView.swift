//
//  TinderCardView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/31.
//

import SwiftUI

struct TinderCardView: View, Identifiable {
    let id = UUID()
    let image: String
    let title: String
    // 拆出來看是因為再Image.overlay巢狀下去會看到眼花。
    var cardName: some View {
        VStack {
            Text(title)
                .font(.system(.headline, design: .rounded))
                .fontWeight(.bold)
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .background(.white)
                .cornerRadius(5)
        }
        .padding([.bottom], 20)
    }
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(10)
            .padding(.horizontal, 15)
            .overlay(alignment: .bottom) {
                cardName
            }
        
    }
}

struct TinderCardView_Previews: PreviewProvider {
    static var previews: some View {
        TinderCardView(image: "yosemite-usa", title: "Yosemite, USA")
    }
}
