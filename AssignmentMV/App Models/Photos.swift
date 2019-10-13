//
//  Photos.swift
//  AssignmentMV
//
//  Created by Mahendra Vishwakarma on 13/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation

// MARK: - Photos
struct Photos: Decodable {
    var photos: PhotosClass
    let stat: String
}

// MARK: - PhotosClass
struct PhotosClass: Decodable {
    let page, pages, perpage:Int
    let total: Total?
    var photo: Array<Photo>
}

// MARK: - Photo
struct Photo: Decodable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}

enum Total: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Total.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for total"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
