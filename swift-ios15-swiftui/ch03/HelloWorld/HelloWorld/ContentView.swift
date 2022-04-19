//
//  ContentView.swift
//  HelloWorld
//
//  Created by Trixie Lulamoon on 2022/4/19.
//

import SwiftUI
// 加入語音功能，使用AVFoundation framework
import AVFoundation

struct ContentView: View {
    var body: some View {
//        //Basic
////        Text("Hello, world!")
////            .padding()
//        //變更字型與顏色
//        Text("Stay Hungry. Stay Foolish.")
//        //想要粗體字
//        //如果你想要更粗一點，則可以選取 heavy 或 black
//            .fontWeight(.bold)
//        // 想要粗體文字更大一點，使用 title 字體以放大文字。
////            .font(.title)
//        // 也可以使用 font 修飾器來指定字型設計
//        // 想要維持.title大小兼字體圓潤
//            .font(.system(.title, design: .rounded))
        
        //將 Hello World 標籤轉成按鈕樣式
        VStack {
            //Happy Programming
            Button {
                // 發出聲音
                speak(text: "Happy Programming")
            } label: {
                Text("Happy Programming")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
            }
            //加入間距
            .padding()
            // 可以使用 foregroundColor 與 background 修飾器來讓按鈕變為紫色。
            .foregroundColor(.white)
            .background(Color.yellow)
            //建立圓角按鈕，同時指定圓角半徑
            .cornerRadius(20)
            // Hello World
            Button {
                // 發出聲音
                speak(text: "Hello World")
            } label: {
                Text("Hello World")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
            }
            //加入間距
            .padding()
            // 可以使用 foregroundColor 與 background 修飾器來讓按鈕變為紫色。
            .foregroundColor(.white)
            .background(Color.purple)
            //建立圓角按鈕，同時指定圓角半徑
            .cornerRadius(20)
        }
        
    }
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
