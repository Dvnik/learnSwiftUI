//
//  SimpleGestureView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/27.
//

import SwiftUI

struct SimpleGestureView: View {
    // tap
    @State private var isTaped = false
    // long press
    @GestureState private var longPressTap = false
    
    //組合手勢
    // 長按手勢
    @GestureState private var isPressed = false

    // 拖曳手勢
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    
    @GestureState private var dragState = DragState.inactive
        
    
    var body: some View {
        
        
        VStack {
            // tap
            Image(systemName: "star.circle.fill")
                .font(.system(size: 100))
                .scaleEffect(isTaped ? 0.5 : 1.0)
                .animation(.easeInOut, value: isTaped)
                .foregroundColor(.secondary)
                .gesture(
                    TapGesture()
                        .onEnded({
                            self.isTaped.toggle()
                        })
                )
            // long press
            Image(systemName: "star.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.red)
                .opacity(longPressTap ? 0.4 : 1.0)
                .scaleEffect(isTaped ? 0.5 : 1.0)
                .animation(.easeInOut, value: isTaped)
                .gesture(
                    LongPressGesture(minimumDuration: 1.0)
                        .updating($longPressTap, body: { (currentState, state, transaction) in
                            state = currentState
                        })
                        .onEnded({ _ in
                            self.isTaped.toggle()
                        })
                )
            // drag
            Image(systemName: "star.circle.fill")
                .font(.system(size: 100))
                .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
                .animation(.easeInOut, value: dragOffset)
                .foregroundColor(.green)
                .gesture(
                    DragGesture()
                        .updating($dragOffset, body: { (value, state, transaction) in

                            state = value.translation
                        })
                        .onEnded({ (value) in
                            self.position.height += value.translation.height
                            self.position.width += value.translation.width
                        })
                )
            
            
            /**
             SwiftUI 可以讓你輕鬆組合手勢，來執行一些複雜的互動。它提供三種手勢組合類型，包括：「同時」（simultaneous ）、「依序」（sequenced ）與「專門」（exclusive ）。
             */
            Image(systemName: "star.circle.fill")
                .font(.system(size: 100))
                .opacity(dragState.isPressing ? 0.5 : 1.0)
                .offset(x: position.width + dragState.translation.width, y: position.height + dragState.translation.height)
                .animation(.easeInOut, value: dragState.translation)
                .foregroundColor(.blue)
                .gesture(
                    LongPressGesture(minimumDuration: 1.0)
                    .sequenced(before: DragGesture())
                    .updating($dragState, body: { (value, state, transaction) in

                        switch value {
                        case .first(true):
                            state = .pressing()
                        case .second(true, let drag):
                            state = .dragging(translation: drag?.translation ?? .zero)
                        default:
                            break
                        }

                    })
                    .onEnded({ (value) in

                        guard case .second(true, let drag?) = value else {
                            return
                        }

                        self.position.height += drag.translation.height
                        self.position.width += drag.translation.width
                    })
                )
            

            
        }
                
                
    }
}

struct SimpleGestureView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleGestureView()
    }
}


