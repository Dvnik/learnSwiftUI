//
//  ContentView.swift
//  SwiftUIImage
//
//  Created by Trixie Lulamoon on 2022/4/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
//            //顯示系統圖片
//            Image(systemName: "cloud.heavyrain")
//            //SF Symbols 與 San Francisco 字型無縫整合。你可以很容易地應用 font 修飾器來進行圖片的縮放。
//                .font(.system(size: 100))
//            //要變更顏色為藍色
//                .foregroundColor(.blue)
//                .shadow(color: .gray, radius: 10, x: 0, y: 10)
//            // 使用自己的圖片
//            Image("paris")
//            //調整圖片大小
//                .resizable()
//            // 針對特定的邊緣來忽略安全區域
//                .ignoresSafeArea(.container, edges: .bottom)
//            // 保持原來的長寬比
//                .scaledToFit()
            
//            Image("paris")
//            //調整圖片大小
//                .resizable()
//            //使用 aspectRatio 修飾器，並設定內容模式（Content Mode）為. fit，這會達成同樣的[保持原來的長寬比]
//                .aspectRatio(contentMode: .fill)
//            //框架（frame ）的寬度為「300 點」
//                .frame(width: 300)
//            //你想要建立圓形圖片，你可以像這樣使用 clipShape 修飾器
//                .clipShape(Circle())
//            //有時你需要將另一個圖片或文字分層放置在圖片視圖之上
//            //例如：你要重疊一個系統圖片（如 heart.fill ）至目前的圖片
//                .overlay(
//                        Image(systemName: "heart.fill")
//                            .font(.system(size: 50))
//                            .foregroundColor(.black)
//                        //控制圖片（或者任何視圖）的不透明度
//                            .opacity(0.5)
//                    )
            // 事實上，你可以採用任何視圖來做重疊。例如：你可以重疊一個 Text 視圖在圖片之上。
            Image("paris")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(

                    Text("If you are lucky enough to have lived in Paris as a young man, then wherever you go for the rest of your life it stays with you, for Paris is a moveable feast.\n\n- Ernest Hemingway")
                        .fontWeight(.heavy)
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                        .opacity(0.8)
                        .padding(),

                    alignment: .top

                )
            // 也可以應用重疊來使圖片變暗
            Image("paris")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(0.4)
                )
            // 可以使用 Color.black 作為上層來將下層的圖片變暗。
            Image("paris")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300)
                .overlay(
                    Color.black
                        .opacity(0.4)
                        .overlay(
                            Text("Paris")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .foregroundColor(.white)
                                .frame(width: 200)
                        )
                )
            // 使用SF Symbol改色
            Image(systemName: "cloud.sun.rain")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.yellow, .blue, .tertiary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
