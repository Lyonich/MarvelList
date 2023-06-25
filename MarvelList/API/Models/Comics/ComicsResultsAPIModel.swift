//
//  ComicsResultsAPIModel.swift
//  MarvelList
//
//  Created by Leonid Kibukevich on 23.07.2021.
//

import Foundation


struct ComicsResultsAPIModel: Decodable {
    let id: Int
    let title: String
    let thumbnail: ThumbnailModel
}
