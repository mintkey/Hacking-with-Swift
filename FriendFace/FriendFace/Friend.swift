//
//  Friend.swift
//  FriendFace
//
//  Created by Helen Dempsey on 5/11/25.
//

import Foundation

struct Friend: Codable, Identifiable, Hashable {
//    enum CodingKeys: String, CodingKey {
//        case _id = "id"
//        case _name = "name"
//    }
    
    let id: String
    let name: String
}
