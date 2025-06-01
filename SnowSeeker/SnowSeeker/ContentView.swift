//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Helen Dempsey on 5/28/25.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var favorites = Favorites()
    @State private var sortType: SortType = .none
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    var sortedResorts: [Resort] {
        switch sortType {
        case .none:
            return resorts
        case .alphabetical:
            return resorts.sorted { $0.name < $1.name }
        case.country:
            return resorts.sorted { $0.country < $1.country }
        }
    }
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
           sortedResorts
        } else {
            sortedResorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    enum SortType: String, CaseIterable, Identifiable {
        case none = "Default"
        case alphabetical = "Alphabetical"
        case country = "Country"

        var id: String { self.rawValue }
    }
    
    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )

                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort by", selection: $sortType) {
                        ForEach(SortType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
