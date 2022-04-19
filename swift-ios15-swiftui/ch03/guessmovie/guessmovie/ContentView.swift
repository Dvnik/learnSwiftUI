//
//  ContentView.swift
//  guessmovie
//
//  Created by Trixie Lulamoon on 2022/4/19.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        
        VStack {
            Text("Guess These Movies")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                        
            Text("Can you guess the movie from these emojis?")
            
            Text("Tap the button to find out the answer")
            
            Button {
                speak(text: "The answer is Back to the Future!")
            } label: {
                Text("👦🏻👴🏻🚗⌚️")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(20)
            
            Button {
                speak(text: "The answer is Frozen!")
            } label: {
                Text("🏰👭🌀❄️☃️")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.yellow)
            .cornerRadius(20)
            
            Button {
                speak(text: "The answer is Ocean 11!")
            } label: {
                Text("🌊1️⃣1️⃣")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(20)
            
            Button {
                speak(text: "The answer is Spiderman!")
            } label: {
                Text("🕷🏃")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.brown)
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
