//
//  MagnifiableView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/27.
//

import SwiftUI

struct MagnifiableView<Content>: View where Content: View {
    
    @GestureState private var scaleFactor: CGFloat = 1.0

    var content: () -> Content

    var body: some View {
        content()
            .scaleEffect(scaleFactor)
            .animation(.default, value: scaleFactor)
            .gesture(MagnificationGesture()
                .updating($scaleFactor, body: { (value, state, transaction) in

                    state = value
                })
            )
    }
}

struct MagnifiableView_Previews: PreviewProvider {
    static var previews: some View {
        MagnifiableView() {
            Image(systemName: "headphones")
                .font(.system(size: 100))
                .foregroundColor(.purple)
        }
    }
}


