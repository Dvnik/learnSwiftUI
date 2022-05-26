//
//  SettingView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/26.
//
//  來源：master SwiftUI ch13,ch14 by AppCoda
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    //SORT PREFERENCE
//    private var displayOrders = [ "Alphabetical", "Show Favorite First", "Show Check-in First"]
//    @State private var selectedOrder = 0
    // 由字串陣列改成列舉
    @State private var selectedOrder = DisplayOrderType.alphabetical

    //FILTER PREFERENCE
    @State private var showCheckInOnly = false
    @State private var maxPriceLevel = 5
    // save store
    @EnvironmentObject var settingStore: SettingStore
    
    var body: some View {
        NavigationView {
            // 表格是一個預定好格式的View，裡面的物件就是表單的"項目"
            VStack {
                Form {
                    // 1
//                    Section(header: Text("SORT PREFERENCE")) {
//                        Picker(selection: $selectedOrder, label: Text("Display order")) {
//                            ForEach(0 ..< displayOrders.count, id: \.self) {
//                                Text(self.displayOrders[$0])
//                            }
//                        }// end picker view
//
//                    }//end section
                    Section(header: Text("SORT PREFERENCE")) {
                        Picker(selection: $selectedOrder, label: Text("Display order")) {
                            ForEach(DisplayOrderType.allCases, id: \.self) {
                                orderType in
                                Text(orderType.text)
                            }
                        }// end picker
                    }// end section
                    // 2
                    Section(header: Text("FILTER PREFERENCE")) {
                        Toggle(isOn: $showCheckInOnly) {
                            Text("Show Check-in Only")
                        }// end toggle

                        Stepper(onIncrement: {
                            self.maxPriceLevel += 1

                            if self.maxPriceLevel > 5 {
                                self.maxPriceLevel = 5
                            }
                        }, onDecrement: {
                            self.maxPriceLevel -= 1

                            if self.maxPriceLevel < 1 {
                                self.maxPriceLevel = 1
                            }
                        }) {
                            Text("Show \(String(repeating: "$", count: maxPriceLevel)) or below")
                        }// end stepper
                    }
                    
                }// end form
                .navigationBarTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            self.settingStore.showCheckInOnly = self.showCheckInOnly
                            self.settingStore.displayOrder = self.selectedOrder
                            self.settingStore.maxPriceLevel = self.maxPriceLevel
                            dismiss()
                        } label: {
                            Text("Save")
                                .foregroundColor(.primary)
                        }
                    }// end Bar item
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                                .foregroundColor(.primary)
                        }
                    }// end bar item
                }// end .toolbar
                
            }
        }// end navigation view
        .onAppear {
            self.selectedOrder = self.settingStore.displayOrder
            self.showCheckInOnly = self.settingStore.showCheckInOnly
            self.maxPriceLevel = self.settingStore.maxPriceLevel
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView().environmentObject(SettingStore())
    }
}
