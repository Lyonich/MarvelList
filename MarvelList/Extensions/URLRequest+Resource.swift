//
//  URLRequest+Resource.swift
//  MarvelList
//
//  Created by Leonid Kibukevich on 20.07.2021.
//

import Foundation


extension URLRequest {
    init(_ resource: Resource) {
        var url = resource.url
        let ts = String(Date.currentTimeStamp)
        let hashString = ts + resource.privateKey + resource.publicKey
        url = url.appending("ts", value: ts)
            .appending("apikey", value: resource.publicKey)
            .appending("hash", value: hashString.MD5())
            .appending("offset", value: String(resource.offset))
            .appending("limit", value: String(resource.limit))
        
        self.init(url: url)
        self.httpMethod = resource.method
    }
}
