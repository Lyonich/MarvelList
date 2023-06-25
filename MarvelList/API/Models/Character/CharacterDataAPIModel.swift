//
//  CharacterDataAPIModel.swift
//  MarvelList
//
//  Created by Leonid Kibukevich on 23.07.2021.
//

import Foundation


struct CharacterDataAPIModel: Decodable {
    let results: [CharacterResultsAPIModel]
}
