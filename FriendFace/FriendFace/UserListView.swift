//
//  UserListView.swift
//  FriendFace
//
//  Created by Helen Dempsey on 5/11/25.
//

import SwiftData
import SwiftUI

struct UserListView: View {
    @Query var users: [User]
    
    var body: some View {
        NavigationStack {
            List(users, id: \.id) { user in
                NavigationLink {
                    UserDetailsView(user: user)
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
    
    init(showActiveOnly: Bool) {
        _users = Query(filter: #Predicate<User> { user in
            if (showActiveOnly == true) {
                user.isActive == true
            } else {
                user.isActive == true || user.isActive == false
            }
        })
    }
}

#Preview {    
    UserListView(showActiveOnly: true)
        .modelContainer(for: User.self)
}
