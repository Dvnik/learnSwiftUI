//
//  CreditCardView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/6/1.
//

import SwiftUI

struct CreditCardView: View {
    var card: Card
    
    @State private var isCardPresented = false
    
    var body: some View {
        Image(card.image)
            .resizable()
            .scaledToFit()
            .overlay(alignment: .bottomLeading, content: {
                VStack(alignment: .leading) {
                    Text(card.number)
                        .bold()

                    HStack {
                        Text(card.name)
                            .bold()
                        Text("Valid Thru")
                            .font(.footnote)
                        Text(card.expiryDate)
                            .font(.footnote)
                    }// end HStack
                }//end VStack
                .foregroundColor(.white)
                .padding(.leading, 25)
                .padding(.bottom, 20)
            })// end .overlay
            .shadow(color: .gray, radius: 1.0, x: 0.0, y: 1.0)
    
    }
}

struct CreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(testCards) { card in
                CreditCardView(card: card).previewLayout(.sizeThatFits)
            }
        }// end group
    }
}
