//
//  EBMLogoView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/24.
//

import SwiftUI

struct EBMLogoView: View {
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                HStack {
                    Group {
                        Circle()
                        Circle()
                        Circle()
                    }
                    .frame(width: 10, height: 10)
                    
                    Text("ebm")
                    Spacer()
                }
                Text("Connecting Healthcare")
            }
            Spacer()
            Circle()
                .frame(width: 50, height: 50)
        }
    }
}

struct EBMLogoView_Previews: PreviewProvider {
    static var previews: some View {
        EBMLogoView()
            .previewLayout(.fixed(width: 282, height: 70))
    }
}
