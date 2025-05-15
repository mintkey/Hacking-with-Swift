//
//  User.swift
//  FriendFace
//
//  Created by Helen Dempsey on 5/11/25.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
//    enum CodingKeys: String, CodingKey {
//        case _id = "id"
//        case _isActive = "isActive"
//        case _name = "name"
//        case _age = "age"
//        case _company = "company"
//        case _email = "email"
//        case _address = "address"
//        case _about = "about"
//        case _registered = "registered"
//        case _tags = "tags"
//        case _friends = "friends"
//    }
    
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
}
