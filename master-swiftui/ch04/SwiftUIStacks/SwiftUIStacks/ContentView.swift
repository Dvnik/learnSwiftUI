//
//  ContentView.swift
//  SwiftUIStacks
//
//  Created by Trixie Lulamoon on 2022/4/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            // 兩個視圖靠左對齊時，你可以指定 alignment 參數，並將其值設定為 .leading
            HeaderView()
            
            HStack(spacing: 15) {
                // Basic
                PricingView(title: "Basic", price: "$9", textColor: .white, bgColor: .purple)
                //Pro
                ZStack {
                    PricingView(title: "Pro", price: "$19", textColor: .black, bgColor: Color(red: 240/255, green: 240/255, blue: 240/255))
                    
                    Text("Best for designer")
                            .font(.system(.caption, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color(red: 255/255, green: 183/255, blue: 37/255))
                            .offset(x: 0, y: 87)
                }
            }
            .padding(.horizontal)
            //作業作答
//            ZStack {
//                PricingView(title: "Team", price: "$299", textColor: .white, bgColor: .black).overlay {
//                    Image(systemName: "wand.and.rays")
//                        .offset(x: 0, y: -67)
//                        .font(.system(size: 40))
//                        .foregroundColor(.white)
//
//                }
//
//                Text("Prefect for teams with 20 members")
//                        .font(.system(.caption, design: .rounded))
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .padding(5)
//                        .background(Color(red: 255/255, green: 183/255, blue: 37/255))
//                        .offset(x: 0, y: 87)
//            }
//            .padding()
            //解答
            ZStack {
                PricingView(title: "Team", price: "$299", textColor: .white, bgColor: Color(red: 62/255, green: 63/255, blue: 70/255), icon: "wand.and.rays")
                    .padding()

                Text("Perfect for teams with 20 members")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color(red: 255/255, green: 183/255, blue: 37/255))
                    .offset(x: 0, y: 87)
            }
            
            // Add a spacer
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        HomeworkView()
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Choose")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
                Text("Your Plan")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
            }

            Spacer()
        }
        .padding()
    }
}
struct PricingView: View {

    var title: String
    var price: String
    var textColor: Color
    var bgColor: Color
    var icon: String?

    var body: some View {
        VStack {

            icon.map({
                Image(systemName: $0)
                    .font(.largeTitle)
                    .foregroundColor(textColor)
            })

            Text(title)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(textColor)
            Text(price)
                .font(.system(size: 40, weight: .heavy, design: .rounded))
                .foregroundColor(textColor)
            Text("per month")
                .font(.headline)
                .foregroundColor(textColor)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
        .padding(40)
        .background(bgColor)
        .cornerRadius(10)
    }
}

struct HomeworkView: View {
    var body: some View {
        ZStack {
            
            PricingView(title: "Basic", price: "$9", textColor: .white, bgColor: .purple, icon: "house.fill")
                .padding()
                .offset(x: 0, y: 180)
            
            PricingView(title: "Pro", price: "$19", textColor: .white, bgColor: Color(red: 255/255, green: 183/255, blue: 37/255), icon: "gamecontroller.fill")
                .padding()
                .scaleEffect(0.95)
            
            PricingView(title: "Team", price: "$299", textColor: .white, bgColor: Color(red: 62/255, green: 63/255, blue: 70/255), icon: "wand.and.rays")
                .padding()
                .scaleEffect(0.9)
                .offset(x: 0, y: -180)
        }
    }
}
