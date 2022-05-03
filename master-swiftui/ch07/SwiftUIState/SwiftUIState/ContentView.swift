//
//  ContentView.swift
//  SwiftUIState
//
//  Created by Trixie Lulamoon on 2022/5/3.
//

import SwiftUI

struct ContentView: View {
    
//    @State private var isPlaying = false
    @State private var counter = 1
    
    var body: some View {
//        Button(action: {
//            // 在「播放」與「停止」按鈕之間切換
//            self.isPlaying.toggle()
//        }) {
//            Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
//            .font(.system(size: 150))
//            .foregroundColor(isPlaying ? .red : .green)
//        }
        VStack {
            CounterButton(counter: $counter, color: .blue)
            CounterButton(counter: $counter, color: .green)
            CounterButton(counter: $counter, color: .red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        HomeworkView()
    }
}

struct CounterButton: View {
    @Binding var counter: Int

    var color: Color
    
    var body: some View {
        Button(action: {
            // 在「播放」與「停止」按鈕之間切換
            self.counter += 1
        }) {
            Circle()
                .frame(width: 120, height: 120)
                .foregroundColor(color)
                .overlay {
                    Text("\(counter)")
                        .font(.system(size: 70, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
        }
    }
}
//MARK: 作業2
struct HomeworkView: View {
    
    
    @State private var btnCount01 = 0
    @State private var btnCount02 = 0
    @State private var btnCount03 = 0
    
    var body: some View {
        VStack {
            let totalCount = btnCount01 + btnCount02 + btnCount03
            Text("\(totalCount)")
                .font(.system(size: 220, weight: .bold, design: .rounded))
            
            HStack {
                CounterButton(counter: $btnCount01, color: .blue)
                CounterButton(counter: $btnCount02, color: .green)
                CounterButton(counter: $btnCount03, color: .red)
            }
            
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
    }
}
