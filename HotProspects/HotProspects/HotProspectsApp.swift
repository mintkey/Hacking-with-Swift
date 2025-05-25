//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Helen Dempsey on 5/24/25.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
