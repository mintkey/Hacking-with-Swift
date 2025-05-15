//
//  ContentView.swift
//  FriendFace
//
//  Created by Helen Dempsey on 5/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationStack {
            UserListView(users: users)
            .navigationTitle(Text("Friend Face"))
            .task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            JSONDecoder().dateDecodingStrategy = .iso8601

            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                users = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
