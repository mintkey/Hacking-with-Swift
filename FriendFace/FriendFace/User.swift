//
//  User.swift
//  FriendFace
//
//  Created by Helen Dempsey on 5/11/25.
//

import Foundation

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _isActive = "isActive"
        case _name = "name"
        case _age = "age"
        case _company = "company"
        case _address = "address"
        case _about = "about"
        case _registered = "registered"
        case _tags = "tags"
        case _friends = "friends"
    }
    
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}
