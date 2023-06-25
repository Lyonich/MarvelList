//
//  Date+CurrentTimeStamp.swift
//  MarvelList
//
//  Created by Leonid Kibukevich on 20.07.2021.
//

import Foundation

extension Date {
    static var currentTimeStamp: Int64{
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
}
