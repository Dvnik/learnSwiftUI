//
//  Photo.swift
//  SwiftUIPhotoGrid
//
//  Created by Trixie Lulamoon on 2022/5/16.
//

import Foundation



struct Photo: Identifiable {
    var id = UUID()
    var name: String
}

let samplePhotos = (1...20).map { Photo(name: "coffee-\($0)") }


