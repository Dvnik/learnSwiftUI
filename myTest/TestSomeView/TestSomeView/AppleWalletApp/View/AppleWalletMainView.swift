//
//  AppleWalletMainView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/6/1.
//

import SwiftUI

struct AppleWalletMainView: View {
    @State var cards: [Card] = testCards
    
    @State var isCardPressed = false
    
    var body: some View {
        VStack {
            WalletTopView()
                .padding(.bottom)
            
            Spacer()
            
            CardListDragView(cards: $cards, isCardPressed: $isCardPressed)
            
            if isCardPressed {
                TransactionHistoryView(transactions: testTransactions)
                    .padding(.top, 10)
                    .transition(.move(edge: .bottom))
            }
            Spacer()
        }//end VStack
    }
    
}

struct AppleWalletMainView_Previews: PreviewProvider {
    static var previews: some View {
        AppleWalletMainView()
    }
}

struct WalletTopView: View {
    var body: some View {
        HStack {
            Text("Wallet")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.heavy)
            Spacer()
            Image(systemName: "plus.circle.fill")
                .font(.system(.title))
        }// end HStack
        .padding(.horizontal)
        .padding(.top, 20)
    }
}


