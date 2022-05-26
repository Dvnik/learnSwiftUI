//
//  Restaurant.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/25.
//

import Foundation

struct Restaurant: Identifiable {
    var id = UUID()
    var name: String
    var type: String?
    var phone: String?
    var image: String
    var priceLevel: Int?
    var isFavorite: Bool = false
    var isCheckIn: Bool = false
}
