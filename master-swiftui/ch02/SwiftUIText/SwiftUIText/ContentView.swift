//
//  ContentView.swift
//  SwiftUIText
//
//  Created by Trixie Lulamoon on 2022/4/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // 簡單文字的呈現
            Text("Hello, world!")
                .padding()
            // 變更字體與顏色
            Text("Stay Hungry. Stay Foolish.")
            //粗體字
                .fontWeight(.bold)
            //想要大一點
//                .font(.title)
            //字體圓潤
//                .font(.system(.largeTitle, design: .rounded))
            //使用一個固定大小的字體
                .font(.system(size: 20))
            //變更字體顏色
                .foregroundColor(.green)
            //多行文字的處理
            // 預設是顯示多行文字
            Text("Your time is limited, so don’t waste it living someone else’s life. Don’t be trapped by dogma—which is living with the results of other people’s thinking. Don’t let the noise of others’ opinions drown out your own inner voice. And most important, have the courage to follow your heart and intuition.")
                .fontWeight(.bold)
//                .font(.title)
                .foregroundColor(.gray)
            //文字置中對齊
                .multilineTextAlignment(.center)
            //限制固定的行數
//                .lineLimit(3)
            //系統預設設定是截斷字尾。要修改文字的截斷模式
                .truncationMode(.head)
            //可以將 .lineLimit 設定為 nil 來看一下結果
                .lineLimit(nil)
            //設定間距與行距
                .lineSpacing(10)
            //要賦予更多間距，你可以使用 padding 修飾器
                .padding()
            //文字的旋轉
            //使用 rotateEffect 修飾器，並傳入旋轉角度
//                .rotationEffect(.degrees(45))
            //如果你想要將文字以特定點來旋轉（譬如左上角）
//                .rotationEffect(.degrees(20), anchor: UnitPoint(x: 0, y: 0))
            //rotation3DEffect 修飾器，可以讓你建立 3D 效果。
            //建立透視文字特效
                .rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
            //建立陰影效果
                .shadow(color: .gray, radius: 2, x: 0, y: 15)
            //自訂字體
                .font(.custom("Nunito", size: 25))
            // 使用 Markdown
            Text("**This is how you bold a text**. *This is how you make text italic.* You can [click this link](https://www.appcoda.com) to go to appcoda.com")
                .font(.title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
