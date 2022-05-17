//
//  View+Ext.swift
//  HomeWorkProgressRing
//
//  Created by Trixie Lulamoon on 2022/5/17.
//

import SwiftUI

extension View {
    func animatableProgressText(progress: Double, textColor: Color = Color.primary) -> some View {
        self.modifier(ProgressTextModifier(progress: progress, textColor: textColor))
    }
}
