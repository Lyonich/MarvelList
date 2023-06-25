//
//  Resource.swift
//  MarvelList
//
//  Created by Leonid Kibukevich on 20.07.2021.
//

import Foundation

struct Resource {
    let url: URL
    let method: String = Constants.APIRequest.getType
    let publicKey: String = Constants.APIRequest.publicKey
    let privateKey: String = Constants.APIRequest.privateKey
    let limit: Int = Constants.pageSize
    let offset: Int
}
