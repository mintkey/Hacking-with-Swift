//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Helen Dempsey on 5/30/25.
//

import SwiftUI

@Observable
class Favorites: Codable {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    init() {
        // load our saved data
        if let data = UserDefaults.standard.data(forKey: "Favorites") {
            if let decodedFavorites = try? JSONDecoder().decode(Favorites.self, from: data) {
                resorts = decodedFavorites.resorts
                return
            }
        }

        // still here? Use an empty array
        resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set and saves the change
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set and saves the change
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: "Favorites")
        }
    }
}
