//
//  BlankView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/6/2.
//

import Foundation
import SwiftUI


struct BlankView : View {

    var bgColor: Color

    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}
