//
//  TinderTripMainView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/31.
//

import SwiftUI

struct TinderTripMainView: View {
    
    @State var cardViews: [TinderCardView] = {
        
        var views = [TinderCardView]()
        
        for index in 0..<2 {
            views.append(TinderCardView(image: trips[index].image, title: trips[index].destination))
        }
        
        return views
    }()
    
    @GestureState private var dragState = DragState.inactive
    
    @State var checkDragging = false
    
    private let dragThreshold: CGFloat = 80.0
    
    @State private var lastIndex = 1
    
    @State private var removalTransition = AnyTransition.trailingBottom
    
    var body: some View {
        VStack {
            TripTopBarMenu()
            ZStack {
                ForEach(cardViews) { cardView in

//                    cardView
//                        .zIndex(self.isTopCard(cardView: cardView) ? 1 : 0)
//                        .offset(x: self.isTopCard(cardView: cardView) ? self.dragState.translation.width : 0, y: self.isTopCard(cardView: cardView) ? self.dragState.translation.height : 0)
//                        .scaleEffect(self.dragState.isDragging && self.isTopCard(cardView: cardView) ? 0.95 : 1.0)
//                        .rotationEffect(Angle(degrees: self.isTopCard(cardView: cardView) ? Double( self.dragState.translation.width / 10) : 0))
//                        .animation(.interpolatingSpring(stiffness: 180, damping: 100))
//                        .transition(self.removalTransition)
//                        .gesture(LongPressGesture(minimumDuration: 0.01)
//                            .sequenced(before: DragGesture())
//                            .updating(self.$dragState, body: { value, state, transaction in
//                                switch value {
//                                case .first(true):
//                                    state = .pressing
//                                case .second(true, let drag):
//                                    state = .dragging(translation: drag?.translation ?? .zero)
//                                default:
//                                    break
//                                }
//                            })// end .updating
//                            .onChanged({ (value) in
//                                guard case .second(true, let drag?) = value else {
//                                    return
//                                }
//
//                                if drag.translation.width < -self.dragThreshold {
//                                    self.removalTransition = .leadingBottom
//                                }
//
//                                if drag.translation.width > self.dragThreshold {
//                                    self.removalTransition = .trailingBottom
//                                }
//
//                            })// end .onChange
//                            .onEnded({ (value) in
//
//                                guard case .second(true, let drag?) = value else {
//                                    return
//                                }
//
//                                if drag.translation.width < -self.dragThreshold ||
//                                    drag.translation.width > self.dragThreshold {
//
//                                    self.moveCard()
//                                }
//                            })//end .onended
//                        )// end .gesture
//                        .overlay {
//                            ZStack {
//                                Image(systemName: "x.circle")
//                                    .foregroundColor(.white)
//                                    .font(.system(size: 100))
//                                    .opacity(self.dragState.translation.width < -self.dragThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0)
//
//                                Image(systemName: "heart.circle")
//                                    .foregroundColor(.white)
//                                    .font(.system(size: 100))
//                                    .opacity(self.dragState.translation.width > self.dragThreshold  && self.isTopCard(cardView: cardView) ? 1.0 : 0.0)
//                            }
//                        }// end .overlay
                        
                    
                    // 測試拉成獨立視圖控制看看
                    // 沒拆出獨立的View的話，卡片移動會變成整個陣列在走
                    // 拆出來有可能是TinderCardDragView變成獨立互相不干擾的View
                    // 才不需要做移動判斷
                    TinderCardDragView(isDargging: $checkDragging) {
                        cardView
                            .zIndex(self.isTopCard(cardView: cardView) ? 1 : 0)
                    } eventDragLeft: {
                        moveCard()
                    } eventDragRight: {
                        moveCard()
                    }
                    
                }
            }
            Spacer(minLength: 20)
            TripBottomBarMenu()
                .opacity(checkDragging ? 0.0 : 1.0)
//                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default)
        }
        
    }
    
    
    //MARK: functions
    private func isTopCard(cardView: TinderCardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else {
                return false
            }
        return index == 0
    }
    
    private func moveCard() {
        cardViews.removeFirst()

        self.lastIndex += 1
        let trip = trips[lastIndex % trips.count]

        let newCardView = TinderCardView(image: trip.image, title: trip.destination)

        cardViews.append(newCardView)
        checkDragging = false
    }
}

struct TinderTripMainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TinderTripMainView()
            TripTopBarMenu()
                .previewLayout(.sizeThatFits)
            TripBottomBarMenu()
                .previewLayout(.sizeThatFits)
        }
        
    }
}
// 頂端
struct TripTopBarMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "line.horizontal.3")
                .font(.system(size: 30))
            
            Spacer()
            
            Image(systemName: "mappin.and.ellipse")
            .font(.system(size: 35))
            
            Spacer()
            
            Image(systemName: "heart.circle.fill")
            .font(.system(size: 30))
        }
        .padding()
    }
}

// 底端
struct TripBottomBarMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "xmark")
                .font(.system(size: 30))
                .foregroundColor(.black)
            Button {
                //
            } label: {
                Text("BOOK IT NOW")
                    .font(.system(.subheadline, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 15)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            Image(systemName: "heart")
                .font(.system(size: 30))
                .foregroundColor(.black)
        }

    }
}

