//
//  SwiftUITransitionView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/24.
//
//  來源：master SwiftUI ch09 by AppCoda
// 轉場效果
import SwiftUI

struct SwiftUITransitionView: View {
    
    @State private var show = false
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 300)
                .foregroundColor(.green)
                .overlay {
                    Text("Show details")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                }
            
            if show {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 300)
                    .foregroundColor(.purple)
                    .overlay {
                        Text("Well, here is the details")
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()
                            .foregroundColor(.white)
                    }
//                    .transition(.offsetScaleOpacity)
                    .transition(.scaleAndOffset)
                
            }
        }
        .onTapGesture {
            withAnimation(Animation.spring()) {
                self.show.toggle()
            }
        }
    }
}

struct SwiftUITransitionView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITransitionView()
    }
}


extension AnyTransition {
    static var offsetScaleOpacity: AnyTransition {
        AnyTransition.offset(x: -600, y: 0).combined(with: .scale).combined(with: .opacity)
    }
    
    static var test01: AnyTransition {
        AnyTransition.scale(scale: 0, anchor: .bottom)
    }
    
    static var test02: AnyTransition {
        AnyTransition.offset(x: -600, y: 0)
    }
    
    static var test03: AnyTransition {
        AnyTransition.offset(x: -600, y: 0).combined(with: .scale)
    }
    static var test04: AnyTransition {
        AnyTransition.offset(x: -600, y: 0).combined(with: .opacity)
    }
    
    static var scaleAndOffset: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .scale(scale: 0, anchor: .bottom),
            removal: .offset(x: -600, y: 00)
        )
    }
    
}
