//
//  Card.swift
//  Flashzilla
//
//  Created by Helen Dempsey on 5/26/25.
//

import Foundation

struct Card: Codable, Identifiable, Equatable {
    var id = UUID()
    var prompt: String
    var answer: String
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
