//
//  UserRegistrationViewModel.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/27.
//


/**
 現在你應該具備 Combine 的一些基本觀念，我們來開始使用框架實作表單驗證，下列是我們將要做的事情：

 建立一個視圖模型來表示使用者註冊表單。
 在視圖模型中實作表單驗證。
 我知道你心裡可能會有幾個問題。首先，為什麼我們需要建立視圖模型呢？我們可以在 ContentView 加入這些表單屬性並執行表單驗證嗎？
 */

import Foundation
import Combine

class UserRegistrationViewModel: ObservableObject {
    // 輸入
    @Published var username = ""
    @Published var password = ""
    @Published var passwordConfirm = ""

    // 輸出
    @Published var isUsernameLengthValid = false
    @Published var isPasswordLengthValid = false
    @Published var isPasswordCapitalLetter = false
    @Published var isPasswordConfirmValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []


    init() {
        $username
            .receive(on: RunLoop.main)
            .map { username in
                return username.count >= 4
            }
            .assign(to: \.isUsernameLengthValid, on: self)
            .store(in: &cancellableSet)

        $password
            .receive(on: RunLoop.main)
            .map { password in
                return password.count >= 8
            }
            .assign(to: \.isPasswordLengthValid, on: self)
            .store(in: &cancellableSet)

        $password
            .receive(on: RunLoop.main)
            .map { password in
                let pattern = "[A-Z]"
                if let _ = password.range(of: pattern, options: .regularExpression) {
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.isPasswordCapitalLetter, on: self)
            .store(in: &cancellableSet)

        Publishers.CombineLatest($password, $passwordConfirm)
            .receive(on: RunLoop.main)
            .map { (password, passwordConfirm) in
                return !passwordConfirm.isEmpty && (passwordConfirm == password)
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
    }
    
}
