//
//  SafariView.swift
//  FoodPin
//
//  Created by Trixie Lulamoon on 2022/4/26.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {

    var url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {

    }
}
