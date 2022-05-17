//
//  TestAddView.swift
//  HomeWorkProgressRing
//
//  Created by Trixie Lulamoon on 2022/5/17.
//

import SwiftUI
// MEMO:SwiftUI 還是可以支援用拖曳的將iOS預存好的UI給引用進畫面
// 但是需要符合SwitUI的方式->即必須對著現存的UI進行疊加
// 對SwiftUI而言不存在「指定UI在(x,y)的位置呈現」
struct TestAddView: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack {
                        ProgressRingView(progress: /*@START_MENU_TOKEN@*/.constant(1.0)/*@END_MENU_TOKEN@*/, thickness: /*@START_MENU_TOKEN@*/12.0/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/130/*@END_MENU_TOKEN@*/, gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [.darkYellow, .lightYellow])/*@END_MENU_TOKEN@*/)
                        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    }
                    Spacer()
                    ProgressRingView(progress: /*@START_MENU_TOKEN@*/.constant(1.0)/*@END_MENU_TOKEN@*/, thickness: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/250/*@END_MENU_TOKEN@*/, gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [.darkPurple, .lightPurple])/*@END_MENU_TOKEN@*/)
                }
                ColorPicker(/*@START_MENU_TOKEN@*/"Title"/*@END_MENU_TOKEN@*/, selection: /*@START_MENU_TOKEN@*/.constant(.red)/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            VStack {
                EditButton()
                Label(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/, systemImage: /*@START_MENU_TOKEN@*/"42.circle"/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct TestAddView_Previews: PreviewProvider {
    static var previews: some View {
        TestAddView()
    }
}
