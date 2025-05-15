//
//  UserListView.swift
//  FriendFace
//
//  Created by Helen Dempsey on 5/11/25.
//

import SwiftUI

struct UserListView: View {
    @State private var selectedUser: User?
    var users: [User]
    
    var body: some View {
        NavigationStack {
            List(users, id: \.id) { user in
                NavigationLink {
                    UserDetailsView(user: user, users: users)
                } label: {
                    VStack {
                        HStack {
                            Text(user.name)
                            
                            Spacer()
                            
                            Text(user.isActive ? Image(systemName: "circle.fill") : Image(systemName: "circle"))
                                .foregroundStyle(user.isActive ? .green : .gray)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let sampleUsers = [
        User(
            id: "50a48fa3-2c0f-4397-ac50-64da464f9954",
            isActive: false,
            name: "Alford Rodriguez",
            age: 21,
            company: "Imkan",
            email: "alfordrodriguez@imkan.com",
            address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
            about: "Occaecat consequat elit aliquip magna laboris...",
            registered: "2015-11-10T01:47:18-00:00",
            tags: [
                "cillum",
                "consequat",
                "deserunt",
                "nostrud",
                "eiusmod",
                "minim",
                "tempor"
            ],
            friends: [
                Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel"),
                Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6", name: "Jewel Sexton")
            ]
        )
    ]
    
    UserListView(users: sampleUsers)
}
