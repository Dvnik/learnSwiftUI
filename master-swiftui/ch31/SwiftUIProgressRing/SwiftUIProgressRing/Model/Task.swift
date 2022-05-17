//
//  Task.swift
//  SwiftUIProgressRing
//
//  Created by Trixie Lulamoon on 2022/5/17.
//

import Foundation

struct Task: Identifiable, Equatable {
    var id = UUID()
    var name: String = ""
    var progress: Double = 0.0 {
        didSet {
            progress = min(progress, 1.0)
        }
    }
    
    init(name: String, progress: Double = 0.0) {
        self.name = name
        self.progress = progress
    }
}


