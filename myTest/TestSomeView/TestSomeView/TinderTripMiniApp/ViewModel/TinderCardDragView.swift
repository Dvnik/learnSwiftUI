//
//  TinderCardDragView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/31.
//

import SwiftUI
// 單純只是要滑動效果的話，應該是辦得到，但是要把數值通用出去就比較困難了

struct TinderCardDragView<Content>: View where Content: View {
    //MARK: private value
    private let dragThreshold: CGFloat = 80.0
    @State private var removalTransition = AnyTransition.trailingBottom
    @GestureState private var dragState = DragState.inactive
    //MARK: value
    @Binding var isDargging: Bool
    
    var content: () -> Content
    var eventDragLeft: () -> Void
    var eventDragRight: () -> Void
    
    var body: some View {
        let dragWidth = self.dragState.translation.width
        let dragHeight = self.dragState.translation.height
        let rotateNum = Double(dragWidth / 10)
        // 移動卡片與否有三個修飾詞會影響，offset, scaleEffect, rotationEffect
        content()
            .offset(x:dragWidth, y: dragHeight)
            .scaleEffect(self.dragState.isDragging ? 0.95 : 1.0)
            .rotationEffect(Angle(degrees: rotateNum))
            .animation(.interpolatingSpring(stiffness: 180, damping: 100))
            .transition(self.removalTransition)
            .gesture(LongPressGesture(minimumDuration: 0.01)
                .sequenced(before: DragGesture())
                .updating(self.$dragState, body: { value, state, transaction in
                    switch value {
                    case .first(true):
                        state = .pressing()
                    case .second(true, let drag):
                        state = .dragging(translation: drag?.translation ?? .zero)
                    default:
                        break
                    }
                    // change state
                    self.isDargging =  self.dragState.isDragging
                })// end .updating
                .onChanged({ (value) in
                    guard case .second(true, let drag?) = value else {
                        return
                    }

                    if drag.translation.width < -self.dragThreshold {
                        self.removalTransition = .leadingBottom
                    }

                    if drag.translation.width > self.dragThreshold {
                        self.removalTransition = .trailingBottom
                    }

                })// end .onChange
                .onEnded({ value in
                    guard case .second(true, let drag?) = value else {
                        return
                    }
                    
                    if drag.translation.width < -self.dragThreshold {
                        self.eventDragLeft()
                    }
                    
                    if drag.translation.width > self.dragThreshold {
                        self.eventDragRight()
                    }
                    
                })//end .onEnded
            )// end .gesture
            .overlay {
                ZStack {
                    Image(systemName: "x.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 100))
                        .opacity(dragWidth < -self.dragThreshold ? 1.0 : 0)
                    
                    Image(systemName: "heart.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 100))
                        .opacity(dragWidth > self.dragThreshold ? 1.0 : 0.0)
                }
            }// end .overlay
    }
}

struct TinderCardDragView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        TinderCardDragView(isDargging: .constant(true)) {
            TinderCardView(image: "yosemite-usa", title: "Yosemite, USA")
        } eventDragLeft: {
            print("leftEvent")
        } eventDragRight: {
            print("rightEvent")
        }

    }
}
