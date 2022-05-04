//
//  ContentView.swift
//  SwiftUIAnimation
//
//  Created by Trixie Lulamoon on 2022/5/3.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: CGFloat = 0.0
    @State private var isLoading = false
    
    var body: some View {

//        ZStack {
//            Text("\(Int(progress * 100))%")
//                .font(.system(.title, design: .rounded))
//                .bold()
//
//            Circle()
//                .stroke(Color(.systemGray5), lineWidth: 10)
//                .frame(width: 150, height: 150)
//
//            Circle()
//                .trim(from: 0, to: progress)
//                .stroke(Color.green, lineWidth: 10)
//                .frame(width: 150, height: 150)
//                .rotationEffect(Angle(degrees: -90))
//        }
//        .onAppear() {
//            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
//                self.progress += 0.05
//                print(self.progress)
//                if self.progress >= 1.0 {
//                    timer.invalidate()
//                }
//            }
//        }
        HStack {
            ForEach(0...4, id: \.self) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.green)
                    .scaleEffect(self.isLoading ? 0 : 1)
                    .animation(.linear(duration: 0.6).repeatForever().delay(0.2 * Double(index)), value: isLoading)
            }
        }
        .onAppear() {
            self.isLoading = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        RecordingButtonAnimationView()
    }
}


struct RecordingButtonAnimationView: View {
    @State private var recordBegin = false
    @State private var recording = false

    var body: some View {
        ZStack {

            RoundedRectangle(cornerRadius: recordBegin ? 30 : 5)
                .frame(width: recordBegin ? 60 : 250, height: 60)
                .foregroundColor(recordBegin ? .red : .green)
                .overlay(
                    Image(systemName: "mic.fill")
                        .font(.system(.title))
                        .foregroundColor(.white)
                        .scaleEffect(recording ? 0.7 : 1)
                )

            RoundedRectangle(cornerRadius: recordBegin ? 35 : 10)
                .trim(from: 0, to: recordBegin ? 0.0001 : 1)
                .stroke(lineWidth: 5)
                .frame(width: recordBegin ? 70 : 260, height: 70)
                .foregroundColor(.green)

        }
        .onTapGesture {
            withAnimation(Animation.spring()) {
                self.recordBegin.toggle()
            }

            withAnimation(Animation.spring().repeatForever().delay(0.5)) {
                self.recording.toggle()
            }
        }
    }
}
