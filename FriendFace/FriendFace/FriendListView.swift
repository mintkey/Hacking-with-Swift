//
//  FriendListView.swift
//  FriendFace
//
//  Created by Helen Dempsey on 5/11/25.
//

import SwiftData
import SwiftUI

struct FriendListView: View {
    var friends: [Friend]
    @Query var users: [User]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(friends.indices, id: \.self) { index in
                let friend = friends[index]
                if let matchedUser = users.first(where: { $0.id == friend.id }) {
                    NavigationLink(destination: UserDetailsView(user: matchedUser)) {
                        Text(friend.name)
                    }
                } else {
                    Text(friend.name)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    let sampleUsers = [
        User(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0",
             isActive: true,
             name: "Hawkins Patel",
             age: 27,
             company: "Mazuda",
             email: "hawkinspatel@mazuda.com",
             address: "256 Union Avenue, Baker, New Mexico, 518",
             about: "Consectetur mollit fugiat dolor ea esse reprehenderit enim laboris laboris. Eiusmod consectetur quis cillum tempor veniam deserunt do. Qui ea amet esse qui mollit non non dolor sint consequat ullamco cillum. Sunt aute elit qui elit.",
             registered: ISO8601DateFormatter().date(from: "2016-02-15T08:16:28-00:00")!,
             tags: [
                 "minim",
                 "commodo",
                 "do",
                 "aliquip",
                 "elit",
                 "incididunt",
                 "pariatur"
             ],
             friends: [
                 Friend(id: "a5050891-c585-4358-87d5-386cf1e93c18",
                     name: "Wall Hart"),
                 Friend(id: "e8ad0264-aaec-436c-ad6c-26b8fe171245",
                     name: "Chase Jensen")
             ],
            ),
        User(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6",
             isActive: true,
             name: "Jewel Sexton",
             age: 31,
             company: "Exoteric",
             email: "jewelsexton@exoteric.com",
             address: "799 Chestnut Street, Bluetown, Kansas, 9874",
             about: "Quis deserunt labore nostrud pariatur culpa velit ea adipisicing. Sit occaecat sint cillum irure eiusmod eu nostrud ex commodo proident incididunt aliqua. Sit fugiat consectetur occaecat ipsum pariatur.",
             registered: ISO8601DateFormatter().date(from: "2014-02-11T09:36:16-00:00")!,
             tags: [
                 "et",
                 "esse",
                 "enim",
                 "qui",
                 "sunt",
                 "ullamco",
                 "irure"
             ],
             friends: [
                 Friend(id: "a5050891-c585-4358-87d5-386cf1e93c18",
                     name: "Wall Hart"),
                 Friend(id: "ac0d097d-e8fd-4d93-9a7b-dead1a7442f0",
                     name: "Thompson Zamora"
                 )
             ]
            ),
        ]
        
    let sampleFriends = sampleUsers.map { user in
        Friend(id: user.id, name: user.name)
    }
    
    FriendListView(friends: sampleFriends)
        .modelContainer(for: User.self)
}
