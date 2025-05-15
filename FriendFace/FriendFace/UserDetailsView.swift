//
//  UserDetailsView.swift
//  FriendFace
//
//  Created by Helen Dempsey on 5/11/25.
//

import SwiftUI

struct UserDetailsView: View {
    var user: User
    var users: [User]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    SectionTitle(text: "Info")
                    
                    Label(text: "Age")
                    Text("\(user.age)")
                    
                    Label(text: "Work")
                    Text("\(user.company)")
                    
                    Label(text: "Email")
                    Text("\(user.email)")
                    
                    Label(text: "Address")
                    Text("\(user.address)")
                
                    SectionTitle(text: "About")
                    
                    Text(user.about)
                    
                    SectionTitle(text: "More")
                    
                    Label(text: "Registered on")
                    Text("\(formattedDate(from: user.registered))")
                    
                    Label(text: "Tags")
                    ForEach(user.tags, id: \.self) { tag in
                        Text(tag)
                            .padding(.horizontal, 10)
                            .foregroundStyle(.gray)
                            .background(Color(.systemGray6))
                            .clipShape(Capsule())
                    }
                    
                    Divider()
                    
                    SectionTitle(text: "Friends")
                    
                    FriendListView(friends: user.friends, users: users)
                }
                .navigationTitle(user.name)
                .padding()
            }
        }
    }
    
    func formattedDate(from isoString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: isoString) else { return "N/A" }

        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .long
        displayFormatter.timeStyle = .none

        return displayFormatter.string(from: date)
    }
}

struct Label: View {
    var text: String
    
    var body: some View {
        Text(text)
            .bold()
            .foregroundStyle(.gray)
    }
}

struct SectionTitle: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title3.bold())
            .padding(.vertical, 5)
    }
}

#Preview {
    let sampleUser =
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
    let sampleUsers = [sampleUser]
    
    UserDetailsView(user: sampleUser, users: sampleUsers)
}
