//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Helen Dempsey on 5/11/25.
//

import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
