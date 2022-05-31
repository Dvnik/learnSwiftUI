//
//  PriceCardView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/23.
//
// 來源：master SwiftUI ch04 by AppCoda

import SwiftUI

struct PriceCardView: View {
    
    // MARK: View value
    var title: String// 標題
    var price: String// 價格
    var cycleLbl: String// 週期循環
    var textColor: Color// 文字顏色
    var bgColor: Color// 背景顏色
    
    var icon: String?
    
    
    var body: some View {
        VStack {
            // .map即展開選擇值來使用
            icon.map {
                // $0則是省略掉變數名稱直接提取「第一個參數」
                Image(systemName: $0)
                    .font(.largeTitle)
                    .foregroundColor(textColor)
            }
            // 用group代表這個Stack的文字顏色是統一顏色
            Group {
                Text(title)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.black)
                Text(price)
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                Text(cycleLbl)
                    .font(.headline)
            }
            .foregroundColor(textColor)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
        .padding(40)
        .background(bgColor)
        .cornerRadius(10)
    }
}

struct PriceCardView_Previews: PreviewProvider {
    static var previews: some View {
        // previewLayout不會用時機規格預覽，如果這個View是小元件就適合這種預覽方式
        PriceCardView(title: "Basic", price: "$9", cycleLbl: "per month", textColor: .black, bgColor: .yellow, icon: "wand.and.rays")
            .previewLayout(.sizeThatFits)
            .padding()
        
        PriceCardExampleView()
    }
}


struct PriceCardExampleView: View {
    // 標題
    var headView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Choose")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
                Text("Your Plan")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.black)
            }
            Spacer()
        }
        .padding()
    }
    //章節範例
    var exampleItem: some View {
        HStack {
            PriceCardView(title: "Basic", price: "$9", cycleLbl: "per month", textColor: .white, bgColor: .primary)
            
            ZStack {
                PriceCardView(title: "Pro", price: "$19", cycleLbl: "per month", textColor: .black, bgColor: Color(red: 240/255, green: 240/255, blue: 240/255))
                // hightLight
                Text("Best for designer")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color(red: 255/255, green: 183/255, blue: 37/255))
                    .offset(x: 0, y: 90)
            }
            
        }
    }
    var body: some View {
        VStack {
            // Stack區塊也可拆分出來
//            HeadView()
            headView
            //
            exampleItem
            // home work : 折疊顯示
            ZStack {
                PriceCardView(title: "Basic", price: "$9", cycleLbl: "per month", textColor: .white, bgColor: .purple, icon: "house.fill")
                    .padding()
                    .scaleEffect(0.4)
                    .offset(x: 0, y: 110)
                PriceCardView(title: "Pro", price: "$19", cycleLbl: "per month", textColor: .white, bgColor: Color(red: 255/255, green: 183/255, blue: 37/255), icon: "house.fill")
                    .padding()
                    .scaleEffect(0.45)
                    .offset(x: 0, y: 20)
                PriceCardView(title: "Team", price: "$299", cycleLbl: "per month", textColor: .white, bgColor: Color(red: 62/255, green: 63/255, blue: 70/255), icon: "wand.and.rays")
                    .padding()
                    .scaleEffect(0.5)
                    .offset(x: 0, y: -70)
            }
            
            Spacer()
        }
    }
    
    
}
