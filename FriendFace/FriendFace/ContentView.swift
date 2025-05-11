//
//  ContentView.swift
//  FriendFace
//
//  Created by Helen Dempsey on 5/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            UsersView()
                .navigationTitle(Text("Friend Face"))
        }
    }
}

#Preview {
    ContentView()
}
