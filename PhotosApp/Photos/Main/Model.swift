//
//  Model.swift
//  Brewery
//
//  Created by Balaji Udayakumar on 3/29/23.
//

import Foundation

struct Image: Decodable {
    let media: Media
}

struct Data: Decodable {
    let items: [Image]
}

struct Media: Decodable {
    let m: String
}
