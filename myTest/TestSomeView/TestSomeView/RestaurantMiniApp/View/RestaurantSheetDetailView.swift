//
//  RestaurantSheetDetailView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/30.
//

import SwiftUI

struct RestaurantSheetDetailView: View {
    let restaurant: Restaurant
    
    @GestureState private var dragState = DragState.inactive
    @State private var positionOffset: CGFloat = 0.0
    
    @State private var viewState = ViewState.half
    @Binding var isShow: Bool
    
    @State private var scrollOffset: CGFloat = 0.0
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HandleBar()
                ScrollView {
                    GeometryReader { scrollViewProxy in
                        Color.clear.preference(key: ScrollOffsetKey.self, value: scrollViewProxy.frame(in: .named("scrollview")).minY)
                    }
                    .frame(height: 0)
                    
                    TitleBar()
                    
                    HeaderView(restaurant: self.restaurant)
                    
                    DetailInfoView(icon: "map", info: self.restaurant.location)
                        .padding(.top)
                    DetailInfoView(icon: "phone", info: self.restaurant.phone)
                    DetailInfoView(icon: nil, info: self.restaurant.description)
                        .padding(.top)
                    DetailInfoView(icon: nil, info: self.restaurant.description)
                        .padding(.top)
                        .padding(.bottom, 100)
                    
                }// end scrollview
                .background(Color.white)
                .cornerRadius(10, antialiased: true)
                .disabled(self.viewState == .half)
                .coordinateSpace(name: "scrollview")
            }//end stack
            .offset(y: geometry.size.height/2 + self.dragState.translation.height + self.positionOffset)
            .offset(y: self.scrollOffset)
            .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0))
            .edgesIgnoringSafeArea(.all)
            .gesture(DragGesture()
                .updating(self.$dragState, body: { (value, state, transaction) in
                    state = .dragging(translation: value.translation)
                    })
                .onEnded({ (value) in

                    if self.viewState == .half {
                        // 界限值 #1
                        // 向上滑動，當它超過界限值時
                        // 透過更新位置偏移量來變更視圖狀態為全部開啟
                        if value.translation.height < -geometry.size.height * 0.25 {
                            self.positionOffset = -geometry.size.height/2 + 50
                            self.viewState = .full
                        }

                        // 界限值 #2
                        // 向下滑動，當它通過界限值
                                  // 透過設定isShow 為 false 來關閉視圖
                        if value.translation.height > geometry.size.height * 0.3 {
                            self.isShow = false
                        }
                    }

                })
            )// end gesture
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                if self.viewState == .full {
                    self.scrollOffset = value > 0 ? value : 0
                    if self.scrollOffset > 120 {
                        
                        self.positionOffset = 0
                        self.scrollOffset = 0
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.viewState = .half
                        }// end dispatch
                    }// end if scrollOffset
                }// end if viewState
            }// end .onPreference
        }// end GeometryReader
        
    }
}

struct RestaurantSheetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantSheetDetailView(restaurant: restaurants[0], isShow: .constant(true))
            .background(Color.black.opacity(0.3))
            .edgesIgnoringSafeArea(.all)
    }
}

// Items
struct HandleBar: View {

    var body: some View {
        Rectangle()
            .frame(width: 50, height: 5)
            .foregroundColor(Color(.systemGray5))
            .cornerRadius(10)
    }
}

struct TitleBar: View {

    var body: some View {
        HStack {
            Text("Restaurant Details")
                .font(.headline)
                .foregroundColor(.primary)

            Spacer()
        }
        .padding()
    }
}

struct HeaderView: View {
    let restaurant: Restaurant

    var body: some View {
        Image(restaurant.image)
            .resizable()
            .scaledToFill()
            .frame(height: 300)
            .clipped()
            .overlay(
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(restaurant.name)
                            .foregroundColor(.white)
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()

                        Text(restaurant.type)
                            .font(.system(.headline, design: .rounded))
                            .padding(5)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(5)

                    }
                    Spacer()
                }
                .padding()
            )
    }
}


struct DetailInfoView: View {
    let icon: String?
    let info: String

    var body: some View  {
        HStack {
            if icon != nil {
                Image(systemName: icon!)
                    .padding(.trailing, 10)
            }
            Text(info)
                .font(.system(.body, design: .rounded))

            Spacer()
        }.padding(.horizontal)
    }
}


enum ViewState {
    case full
    case half
}

struct ScrollOffsetKey: PreferenceKey {
    typealias Value = CGFloat

    static var defaultValue = CGFloat.zero

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
