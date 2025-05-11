//
//  Friend.swift
//  FriendFace
//
//  Created by Helen Dempsey on 5/11/25.
//

import Foundation

@Observable
class Friend: Codable {
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _name = "name"
    }
    
    var id = ""
    var name = ""
}
