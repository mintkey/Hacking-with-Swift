//
//  DetailView.swift
//  HabitTracker
//
//  Created by Helen Dempsey on 5/1/25.
//

import SwiftUI

struct DetailView: View {
    @Bindable var activities: Activities
    var item: ActivityItem
    
    var body: some View {
        VStack {
            Text(item.emoji ?? "")
                .font(.system(size: 72))
            
            Text(item.title)
                .font(.largeTitle.bold())
            
            Text(item.description)
                .font(.title2)
            
            
            Text("Times completed: \(item.completionCount)")
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background(Color.gray.opacity(0.2))
                .clipShape(.rect(cornerRadius: 20))
            
            Button {
                incrementCompletionCount()
            } label: {
                Text("\(Image(systemName: "checkmark")) Mark as complete")
            }
            .padding(.vertical, 50)
        }
    }
    
    func incrementCompletionCount() {
        if let index = activities.items.firstIndex(of: item) {
            var newActivity = activities.items[index]
            newActivity.completionCount += 1
            activities.items[index] = newActivity
        }
    }
}

#Preview {
    let sampleItem = ActivityItem(emoji: "🎹", title: "Play piano", description: "Play piano for 1 hour", completionCount: 1)
    let sampleActivities = Activities()
    sampleActivities.items = [sampleItem]

    return DetailView(activities: sampleActivities, item: sampleItem)
}
