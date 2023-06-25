//
//  ComicsListModel.swift
//  MarvelList
//
//  Created by Leonid Kibukevich on 23.07.2021.
//

import UIKit

struct ComicsListModel {
    let title: String
    let cover: UIImage
    
    init(title: String, cover: UIImage) {
        self.title = title
        self.cover = cover
    }
}
