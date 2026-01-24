//
//  ViewModel.swift
//  CollectionViewGrids
//
//  Created by Pablo Romero on 24/1/26.
//

import UIKit

struct ImageItem: Hashable {
    let id: UUID
    let imageName: String
    
    init(id: UUID = UUID(), imageName: String) {
        self.id = id
        self.imageName = imageName
    }
}

class ImagesViewModel {
    var items: [ImageItem] = []
    
    init() {
        items = [
            ImageItem(imageName: "photo.fill"),
            ImageItem(imageName: "photo.fill"),
            ImageItem(imageName: "photo.fill"),
            ImageItem(imageName: "photo.fill"),
            ImageItem(imageName: "photo.fill"),
            ImageItem(imageName: "photo.fill"),
            ImageItem(imageName: "photo.fill"),
            ImageItem(imageName: "photo.fill"),
            ImageItem(imageName: "photo.fill"),
            ImageItem(imageName: "photo.fill"),
            ImageItem(imageName: "photo.fill")
        ]
    }
}
