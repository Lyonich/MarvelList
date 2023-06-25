//
//  URLS.swift
//  MarvelList
//
//  Created by Leonid Kibukevich on 21.07.2021.
//

import Foundation

enum APIEnpoints {
    static private let base = "https://gateway.marvel.com/v1/public/"
    static private let characterEndpoint = APIEnpoints.base + "characters"
    static private let allComics = APIEnpoints.characterEndpoint + "/%d/" + "comics"
    
    case allCharacters
    case allComics(id: Int)
    
    var path: URL {
        switch self {
        case .allCharacters:
            return URL(string: APIEnpoints.characterEndpoint)!
        case let .allComics(id):
            return URL(string: String(format: APIEnpoints.allComics, id))!
        }
    }
}
