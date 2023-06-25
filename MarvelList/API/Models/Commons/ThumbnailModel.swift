//
//  ThumbnailModel.swift
//  MarvelList
//
//  Created by Leonid Kibukevich on 23.07.2021.
//

import Foundation


struct ThumbnailModel: Decodable {
    let path: String
    let extensionImage: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case extensionImage = "extension"
    }
}
