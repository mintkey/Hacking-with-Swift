//
//  ContentView.swift
//  HabitTracker
//
//  Created by Helen Dempsey on 5/1/25.
//

import SwiftUI

import Observation
import SwiftUI

struct ActivityItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let emoji: String?
    let title: String
    let description: String
    var completionCount: Int
}

@Observable
class Activities {
    var items = [ActivityItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ActivityItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    @State private var activities = Activities()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.items) { item in
                    NavigationLink {
                        DetailView(activities: activities, item: item)
                    } label: {
                        Text("\(item.emoji ?? "") \(item.title)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button("New Activity") {
                    showingAddActivity = true
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddView(activities: activities)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
