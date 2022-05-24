//
//  CountDownView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/24.
//
//  來源：master SwiftUI ch07 by AppCoda

import SwiftUI

struct CountDownView: View {
    @State private var counter = 1
    
    var body: some View {
        VStack {
            CounterButton(counter: $counter, color: .blue)
            CounterButton(counter: $counter, color: .green)
            CounterButton(counter: $counter, color: .red)
        }
    }
}

struct CountDownView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownView()
    }
}

struct CounterButton: View {

    @Binding var counter: Int

    var color: Color

    var body: some View {
        Button(action: {
            self.counter += 1
        }) {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(color)
                .overlay {
                    Text("\(counter)")
                        .font(.system(size: 100, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
        }
    }
}
