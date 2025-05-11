//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Helen Dempsey on 5/3/25.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
