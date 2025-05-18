//
//  ContentView.swift
//  FriendFace
//
//  Created by Helen Dempsey on 5/11/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    @State private var showingActiveOnly = false
    
    var body: some View {
        NavigationStack {
            UserListView(showActiveOnly: showingActiveOnly)
            .navigationTitle(Text("Friend Face"))
            .toolbar {
                Button(showingActiveOnly ? "Show Everyone" : "Show Active Only") {
                    showingActiveOnly.toggle()
                }
            }
            .task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        try? modelContext.delete(model: User.self)
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedUsers = try? decoder.decode([User].self, from: data) {
                for user in decodedUsers {
                    modelContext.insert(user)
                }
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
