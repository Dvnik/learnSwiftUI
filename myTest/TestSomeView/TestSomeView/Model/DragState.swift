//
//  DragState.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/31.
//

import Foundation
import SwiftUI

// 這裡有三種狀態：「靜止」（inactive ）、「按下」（pressing ）與「拖曳」（dragging ）
enum DragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)

    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .dragging:
            return true
        case .pressing, .inactive:
            return false
        }
    }

    var isPressing: Bool {
        switch self {
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }
}
