//
//  Card.swift
//  Flashzilla
//
//  Created by Helen Dempsey on 5/26/25.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
