//
//  MarvelListMarvelListModel.swift
//  MarvelList
//
//  Created by Lyonich on 21/07/2021.
//  Copyright 2021 Home. All rights reserved.
//

import UIKit

class CharacterListModel {
    let id: Int
    let name: String
    let avatar: UIImage
    var isSelected: Bool
    
    init(id: Int, name: String, avatar: UIImage, isSelected: Bool) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.isSelected = isSelected
    }
}
