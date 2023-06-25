//
//  CharacterCell.swift
//  MarvelList
//
//  Created by Leonid Kibukevich on 21.07.2021.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    
    func setData(_ data: CharacterListModel) {
        imageView.image = data.avatar
        imageView.alpha = data.isSelected ? 1 : 0.5
    }
    
}
