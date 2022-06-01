//
//  WalletView.swift
//  SwiftUIWallet
//
//  Created by Trixie Lulamoon on 2022/5/10.
//

import SwiftUI

struct WalletView: View {
    @State var cards: [Card] = testCards
    @State private var isCardPresented = false
    @State var isCardPressed = false
    @State var selectedCard: Card?
    @GestureState private var dragState = DragState.inactive
    private static let cardOffset: CGFloat = 50.0
    
    var body: some View {
       VStack {

            TopNavBar()
                .padding(.bottom)

            Spacer()

           ZStack {
               if isCardPresented {
                   ForEach(cards) { card in
                       CardView(card: card)
                           .offset(self.offset(for: card))
                           .padding(.horizontal, 35)
                           .zIndex(self.zIndex(for: card))
                           .transition(AnyTransition.slide.combined(with: .move(edge: .leading)).combined(with: .opacity))
                           .animation(self.transitionAnimation(for: card))
                           .gesture(
                               TapGesture()
                                   .onEnded({ _ in
                                       withAnimation(.easeOut(duration: 0.15).delay(0.1)) {
                                           self.isCardPressed.toggle()
                                           self.selectedCard = self.isCardPressed ? card : nil
                                       }
                                   })
                                   .exclusively(before: LongPressGesture(minimumDuration: 0.05)
                                    .sequenced(before: DragGesture())
                                    .updating(self.$dragState, body: { (value, state, transaction) in
                                       switch value {
                                       case .first(true):
                                           state = .pressing(index: self.index(for: card))
                                       case .second(true, let drag):
                                           state = .dragging(index: self.index(for: card), translation: drag?.translation ?? .zero)
                                       default:
                                           break
                                       }

                                   })
                                   .onEnded({ (value) in

                                       guard case .second(true, let drag?) = value else {
                                           return
                                       }

                                       // 重新排列卡片
                                       self.rearrangeCards(with: card, dragOffset: drag.translation)
                                   })

                               )
                           )
                   }
               }
           }
           .onAppear {
               self.isCardPresented.toggle()
           }

            Spacer()
        }
    }
    // 反轉index順序，第一張卡應該要在疊層的最上面
    private func zIndex(for card: Card) -> Double {
        guard let cardIndex = index(for: card) else {
            return 0.0
        }

        // 卡片的預設 z-index 設定為卡片索引值的負值，
        // 因此第一張卡片具有最大的 z-index
        let defaultZIndex = -Double(cardIndex)

        // 如果它是拖曳的卡片
        if let draggingIndex = dragState.index,
            cardIndex == draggingIndex {
            // 我們根據位移的高度來計算新的 z-index
            return defaultZIndex + Double(dragState.translation.height/Self.cardOffset)
        }

        // 否則我們回傳預設的 z-index
        return defaultZIndex
    }
//找出卡片在陣列中的位置
    private func index(for card: Card) -> Int? {
        guard let index = cards.firstIndex(where: { $0.id == card.id }) else {
            return nil
        }

        return index
    }
    //計算卡片的偏移位置
    private func offset(for card: Card) -> CGSize {

        guard let cardIndex = index(for: card) else {
            return CGSize()
        }

        if isCardPressed {
            guard let selectedCard = self.selectedCard,
                let selectedCardIndex = index(for: selectedCard) else {
                    return .zero
            }

            if cardIndex >= selectedCardIndex {
                return .zero
            }

            let offset = CGSize(width: 0, height: 1400)

            return offset
        }

        // 處理手勢
        var pressedOffset = CGSize.zero
        var dragOffsetY: CGFloat = 0.0

        if let draggingIndex = dragState.index,
            cardIndex == draggingIndex {
            pressedOffset.height = dragState.isPressing ? -20 : 0

            switch dragState.translation.width {
            case let width where width < -10: pressedOffset.width = -20
            case let width where width > 10: pressedOffset.width = 20
            default: break
            }

            dragOffsetY = dragState.translation.height
        }

        return CGSize(width: 0 + pressedOffset.width, height: -50 * CGFloat(cardIndex) + pressedOffset.height + dragOffsetY)
    }
    //卡片動畫
    private func transitionAnimation(for card: Card) -> Animation {
        var delay = 0.0

        if let index = index(for: card) {
            delay = Double(cards.count - index) * 0.1
        }

        return Animation.spring(response: 0.1, dampingFraction: 0.8, blendDuration: 0.02).delay(delay)
    }
    
    private func rearrangeCards(with card: Card, dragOffset: CGSize) {
        guard let draggingCardIndex = index(for: card) else {
            return
        }

        var newIndex = draggingCardIndex + Int(-dragOffset.height / Self.cardOffset)
        newIndex = newIndex >= cards.count ? cards.count - 1 : newIndex
        newIndex = newIndex < 0 ? 0 : newIndex

        let removedCard = cards.remove(at: draggingCardIndex)
        cards.insert(removedCard, at: newIndex)

    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}

struct TopNavBar: View {

    var body: some View {
        HStack {
            Text("Wallet")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.heavy)

            Spacer()

            Image(systemName: "plus.circle.fill")
                .font(.system(.title))
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}


enum DragState {
    case inactive
    case pressing(index: Int? = nil)
    case dragging(index: Int? = nil, translation: CGSize)

    var index: Int? {
        switch self {
        case .pressing(let index), .dragging(let index, _):
            return index
        case .inactive:
            return nil
        }
    }
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(_, let translation):
            return translation
        }
    }

    var isPressing: Bool {
        switch self {
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }

    var isDragging: Bool {
        switch self {
        case .dragging:
            return true
        case .inactive, .pressing:
            return false
        }
    }
}
