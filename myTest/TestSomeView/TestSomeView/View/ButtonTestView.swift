//
//  ButtonTestView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/23.
//
//  來源：master SwiftUI ch06 by AppCoda

import SwiftUI

struct ButtonTestView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .fontWeight(.bold)
                .font(.title)
                .padding()
                .background(Color.purple)
                .cornerRadius(40)
                .foregroundColor(.white)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.purple, lineWidth: 5)
            )
//
//            Button(action: {
//                print("Delete tapped!")
//            }) {
//                HStack {
//                    Image(systemName: "trash")
//                        .font(.title)
//                    Text("Delete")
//                        .fontWeight(.semibold)
//                        .font(.title)
//                }
//                .padding()
//                .foregroundColor(.white)
//                .background(Color.red)
//                .cornerRadius(40)
//            }
            
//            Button {
//                print("Delete tapped!")
//            } label: {
//                Label {
//                    Text("Delete")
//                        .fontWeight(.semibold)
//                        .font(.title)
//                } icon: {
//                    Image(systemName: "trash")
//                        .font(.title)
//                }
//                .padding()
//                .foregroundColor(.white)
//                .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
//                .cornerRadius(40)
//                .shadow(color: .gray, radius: 20.0, x: 20, y: 10)
//
//            }
//            Button(action: {
//                print("Delete tapped!")
//            }) {
//                HStack {
//                    Image(systemName: "trash")
//                        .font(.title)
//                    Text("Delete")
//                        .fontWeight(.semibold)
//                        .font(.title)
//                }
//                .frame(minWidth: 0, maxWidth: .infinity)
//                .padding()
//                .foregroundColor(.white)
//                .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
//                .cornerRadius(40)
//                .padding(.horizontal, 20)
//            }
            
            
            Button(action: {
                print("Edit tapped!")
            }) {
                HStack {
                    Image(systemName: "square.and.pencil")
                        .font(.title)
                    Text("Edit")
                        .fontWeight(.semibold)
                        .font(.title)
                }
            }
            .buttonStyle(GradientBackgroundStyle())

            Button(action: {}) {
                Text("Buy me a coffee")
            }
            .tint(.purple)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: 5))
            .controlSize(.large)
            
            VStack {
                Button(action: {}) {
                    Text("Add to Cart")
                        .font(.headline)
                }

                Button(action: {}) {
                    Text("Discover")
                        .font(.headline)
                        .frame(maxWidth: 300)
                }

                Button(action: {}) {
                    Text("Check out")
                        .font(.headline)
                }
            }
            .tint(.purple)
            .buttonStyle(.bordered)
            .controlSize(.large)
            
            //ios15的role可以預設按鈕的類型
            Button("Delete", role: .destructive) {
                print("Delete")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            Button("Delete", role: .destructive) {
                print("Delete")
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            
            Button("Cancel", role: .cancel) {
                print("Cancel")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            Button("Cancel", role: .cancel) {
                print("Cancel")
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
        }
    }
}

struct ButtonTestView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTestView()
    }
}

//為按鈕的樣式做出自定義的內容
struct GradientBackgroundStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .padding(.horizontal, 20)
                    .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
