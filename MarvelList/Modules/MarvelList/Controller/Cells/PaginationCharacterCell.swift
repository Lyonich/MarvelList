//
//  PaginationCharacterCell.swift
//  MarvelList
//
//  Created by Leonid Kibukevich on 23.07.2021.
//

import UIKit

class PaginationCharacterCell: UICollectionViewCell {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        activityIndicator.startAnimating()
    }
}
