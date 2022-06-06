//
//  MySearchBar.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/6/2.
//

import SwiftUI

struct MySearchBar: View {
    @Binding var text: String
    
    @State private var isEditing = false
    // 客製化綁定，將每段單字字首大寫
    // Swift 5.1 就有的一項新功能
    private var searchText: Binding<String> {

        Binding<String>(
            get: {
                self.text.capitalized

            }, set: {
                self.text = $0
            }
        )
    }
    
    var body: some View {
        HStack {

            TextField("Search ...", text: searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }


            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    // 關閉鍵盤
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }// end HStack
    }
}

struct MySearchBar_Previews: PreviewProvider {
    static var previews: some View {
        MySearchBar(text: .constant(""))
    }
}
