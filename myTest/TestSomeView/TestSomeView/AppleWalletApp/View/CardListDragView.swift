//
//  CardListDragView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/6/1.
//

import SwiftUI

struct CardListDragView: View {
    @Binding var cards: [Card]
    @Binding var isCardPressed: Bool
    
    private static let cardOffset: CGFloat = 50.0
    
    @State var isCardPresented = false
    @State var selectedCard: Card?
    
    @GestureState private var dragState = DragState.inactive
    
    var body: some View {
        ZStack {
            if isCardPresented {
                ForEach(cards) { card in
                    CreditCardView(card: card)
                        .offset(self.offset(for: card))
                        .padding(.horizontal, 35)
                        .zIndex(self.zIndex(for: card))
                        .transition(AnyTransition.slide.combined(with: .move(edge: .leading)).combined(with: .opacity))
                        .animation(self.transitionAnimation(for: card))
                        .gesture(tapCard(card: card))
                }// end ForEach
            }// end if
        }//end ZStack
        .onAppear {
            self.isCardPresented.toggle()
        }
    }
    
    //MARK: functions
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
    
    private func index(for card: Card) -> Int? {
        guard let index = cards.firstIndex(where: {$0.id == card.id}) else {
            return nil
        }
        return index
    }
    
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
            case let width where width < -10:
                pressedOffset.width = -20
            case let width where width > 10:
                pressedOffset.width = 20
            default:
                break
            }
            dragOffsetY = dragState.translation.height
        }//end if
        return CGSize(width: 0 + pressedOffset.width,
                      height: -50 * CGFloat(cardIndex) + pressedOffset.height + dragOffsetY)
    }
    // 移動動畫
    private func transitionAnimation(for card: Card) -> Animation {
        var delay = 0.0

        if let index = index(for: card) {
            delay = Double(cards.count - index) * 0.1
        }

        return Animation.spring(response: 0.1, dampingFraction: 0.8, blendDuration: 0.02).delay(delay)
    }
    //重新排列卡片
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
    //MARK: Gesture
    // 為了不要讓程式變得凌亂，程式會有多層的縮排
    // 所以拆出來，一種作法是some Gesture變數。
    // 但因為要將回圈的card做即時的調用，所以寫成方法帶入參數才能解決。
    func tapCard(card: Card) -> some Gesture {
        TapGesture()
            .onEnded({ _ in
                withAnimation(.easeOut(duration: 0.15).delay(0.1)) {
                    self.isCardPressed.toggle()
                    self.selectedCard = self.isCardPressed ? card : nil
                }// end withAnimation
            })// end .onEnded
            .exclusively(before: longPressCard(card: card))
    }
    // LongPressGesture從TapGesture的exclusively拆出來也是相同理由。
    func longPressCard(card: Card) -> some Gesture {
        LongPressGesture(minimumDuration: 0.05)
            .sequenced(before: DragGesture())
            .updating(self.$dragState, body: { value, state, transaction in
                switch value {
                case .first(true):
                    state = .pressing(index: self.index(for: card))
                case .second(true, let drag):
                    state = .dragging(index: self.index(for: card), translation: drag?.translation ?? .zero)
                default:
                    break
                }
            })//end .updating
            .onEnded({ value in
                guard case .second(true, let drag?) = value else {
                    return
                }
                // 重新排列卡片
                self.rearrangeCards(with: card, dragOffset: drag.translation)
            })//end .onEnded
    }
}

struct CardListDragView_Previews: PreviewProvider {
    static var previews: some View {
        CardListDragView(cards: .constant(testCards), isCardPressed: .constant(false))
    }
}
