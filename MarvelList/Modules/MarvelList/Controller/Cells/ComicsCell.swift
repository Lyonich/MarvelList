//
//  CharacterDetailCell.swift
//  MarvelList
//
//  Created by Leonid Kibukevich on 22.07.2021.
//

import UIKit

class ComicsCell: UITableViewCell {
    @IBOutlet private weak var detailImageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    
    func setData(_ data: ComicsListModel) {
        detailImageView.image = data.cover
        label.text = data.title
    }

}
