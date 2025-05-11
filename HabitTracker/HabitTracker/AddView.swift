//
//  AddView.swift
//  HabitTracker
//
//  Created by Helen Dempsey on 5/1/25.
//

import SwiftUI

struct AddView: View {
    @State private var emoji = ""
    @State private var title = ""
    @State private var description = ""
    @Environment(\.dismiss) var dismiss

    var activities: Activities

    var body: some View {
        NavigationStack {
            Form {
                TextField("Emoji (optional)", text: $emoji)
                
                TextField("Name of activity", text: $title)
                
                TextField("Description", text: $description, axis: .vertical)
            }
            .navigationTitle("New Activity")
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        let item = ActivityItem(emoji: emoji, title: title, description: description, completionCount: 1)
                        activities.items.append(item)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddView(activities: Activities())
}
