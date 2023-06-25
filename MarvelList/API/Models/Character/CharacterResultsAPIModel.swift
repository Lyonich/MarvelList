//
//  CharacterResultsAPIModel.swift
//  MarvelList
//
//  Created by Leonid Kibukevich on 23.07.2021.
//

import Foundation


struct CharacterResultsAPIModel: Decodable {
    let id: Int
    let name: String
    let thumbnail: ThumbnailModel
}
