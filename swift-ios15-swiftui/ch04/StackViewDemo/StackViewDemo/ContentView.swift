//
//  ContentView.swift
//  StackViewDemo
//
//  Created by Trixie Lulamoon on 2022/4/19.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text("Instant Developer")
                    .fontWeight(.medium)
                    .font(.system(size: 40))
                    .foregroundColor(.indigo)

                Text("Get help from experts in 15 minutes")
            }
            
            HStack(alignment: .bottom, spacing: 10) {
                Image("user1")
                // 將圖片延伸充滿整個區域
                    .resizable()
                // 要保有原來圖片的長寬比
                    .scaledToFit()
                // 與scaledToFit相同作法
//                .aspectRatio(contentMode: .fit)
                Image("user2")
                    .resizable()
                    .scaledToFit()
                Image("user3")
                    .resizable()
                    .scaledToFit()
            }
            .padding(.horizontal, 20)
            
            Text("Need help with coding problems? Register!")
            
            Spacer()
            
            if verticalSizeClass == .compact {
                HSignUpButtonGroup()
            } else {
                VSignUpButtonGroup()
            }
        }
        .padding(.top, 30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            //指定要使用的模擬器
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
            //取代顯示「Preview」的名稱
            .previewDisplayName("iPhone 12 Pro")
            
//            ContentView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
//                .previewDisplayName("iPhone 12 Pro")
//                .previewInterfaceOrientation(.landscapeLeft)
//
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
            
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
            .previewDisplayName("iPad Air")
        }
    }
}

struct VSignUpButtonGroup: View {
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Text("Sign Up")
            }
            .frame(width: 200)
            .padding()
            .foregroundColor(.white)
            .background(Color.indigo)
            .cornerRadius(10)
            
            Button {
                
            } label: {
                Text("Log In")
            }
            .frame(width: 200)
            .padding()
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(10)
        }
    }
}

struct HSignUpButtonGroup: View {
    var body: some View {
        HStack {
            Button {

            } label: {
                Text("Sign Up")
            }
            .frame(width: 200)
            .padding()
            .foregroundColor(.white)
            .background(Color.indigo)
            .cornerRadius(10)

            Button {

            } label: {
                Text("Log In")
            }
            .frame(width: 200)
            .padding()
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(10)
        }
    }
}
