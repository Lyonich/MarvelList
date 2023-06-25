//
//  Result.swift
//  MarvelList
//
//  Created by Leonid Kibukevich on 20.07.2021.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
