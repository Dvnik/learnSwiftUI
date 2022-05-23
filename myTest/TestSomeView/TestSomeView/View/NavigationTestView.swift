//
//  NavigationTestView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/20.
//

import SwiftUI

struct NavigationTestView: View {
    let songs = ["怎樣", "街角的祝福", "野薔薇", "愛瘋了", "光著我的腳丫子", "多麼想念你", "一個人的行李", "習慣這樣", "不想"]
    
    var body: some View {
        NavigationView {
            List(songs, id: \.self) { song  in
                
                NavigationLink {
                    Text(song)
                } label: {
                    Text(song)
                }
            }
            .navigationBarTitle("戴佩妮")
            
            
            // 依然能檢查裝置
            if UIDevice.current.userInterfaceIdiom == .pad {
                Text("Is Pad mode")
            }
            else {
                Text("Hello World")
            }
        }
        // 強制NavigationView用在iPad堆疊方式作為主畫面，就要下這條
        .navigationViewStyle(.stack)
    }
}

struct NavigationTestView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            //不指定就是XCode上當前指到的UI
            NavigationTestView()
            // previewDevice可以指定預覽的設備
            NavigationTestView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
                .previewDisplayName("iPhone 13 Pro")
            
            NavigationTestView()
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (5th generation)"))
                .previewDisplayName("iPad Pro")
            
        }
    }
}
