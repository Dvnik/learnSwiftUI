//
//  ContentView.swift
//  SwiftUIAnimationHomeWork
//
//  Created by Trixie Lulamoon on 2022/5/4.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        Work01View()
        Work02View()
    }
}


//MARK: Work 01
struct Work01View: View {
    @State private var processing = false
    @State private var completed = false
    @State private var loading = false
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: processing ? 250 : 200, height: 60)
                .foregroundColor(completed ? .red : .green)
            
            if !processing {
                Text("Submit")
                    .font(.system(.title, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .transition(.move(edge: .top))
            }
            
            
            if processing && !completed {
                
                HStack {
                    Circle()
                        .trim(from: 0, to: 0.9)
                        .stroke(.white, lineWidth: 3)
                        .frame(width: 30, height: 30)
                        .rotationEffect(.degrees(loading ? 360 : 0))
                        .animation(.easeOut.repeatForever(autoreverses: false), value: loading)
                    Text("Processing")
                        .font(.system(.title, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                    
                }
                .transition(.opacity)
                .onAppear() {
                    self.startProcessing()
                }
            }
            
            
            if completed {
                Text("Done")
                    .font(.system(.title, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .onAppear() {
                        self.endProcessing()
                    }
            }
            
            
            
        }
        .animation(.spring(), value: loading)
        .onTapGesture {
            if !loading {
                self.processing.toggle()
            }
        }
    }
    
    
    
    
    
    
    
    
    
    private func startProcessing() {
        self.loading = true
        
        // Simulate an operation by using DispatchQueue.main.asyncAfter
        // In a real world project, you will perform a task here.
        // When the task finishes, you set the completed status to true
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.completed = true
        }
    }
    
    private func endProcessing() {
        // Reset the button's state
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.processing = false
            self.completed = false
            self.loading = false
        }
    }
    
    
}

//MARK: Work 02


struct Work02View: View {
    @State private var show = false
    @State private var currentCardIndex = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
                    
            Text("Reading List")
                .font(.system(size: 70, weight: .black, design: .rounded))
                .padding([.top, .horizontal])
            
            if !show {
                cardViews[currentCardIndex]
                    .transition(.scaleDownAndUp)
            }
            
            if show {
                cardViews[currentCardIndex]
                    .transition(.scaleDownAndUp)
            }
            
            Spacer()
        }
        .onTapGesture {
            
            self.currentCardIndex = (self.currentCardIndex + 1) % cardViews.count
            
            withAnimation(Animation.spring()) {
                self.show.toggle()
            }
            
        }
    }
}
extension AnyTransition {
    static var scaleDownAndUp: AnyTransition {
        AnyTransition.offset(y: 600).combined(with: .scale(scale: 0, anchor: .bottom)).combined(with: .opacity)
    }
    
    static var slideInAndOut: AnyTransition {
        AnyTransition.asymmetric(
            insertion: AnyTransition.offset(x: 800).combined(with: .opacity).combined(with: .scale(scale: 0, anchor: .trailing)),
            removal: AnyTransition.offset(x: -800).combined(with: .opacity).combined(with: .scale(scale: 0, anchor: .leading))
        )
    }

}
