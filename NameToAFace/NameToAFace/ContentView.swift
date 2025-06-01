//
//  ContentView.swift
//  NameToAFace
//
//  Created by Helen Dempsey on 5/24/25.
//

import CoreImage
import MapKit
import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var people: [Person] = []
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingAddPerson = false
    let savePath = URL.documentsDirectory.appending(path: "SavedPeople")
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationStack {
            NamesAndFacesView(people: people)
                .navigationTitle("Name to a Face")
                .toolbar {
                    Button("Add person") {
                        showingAddPerson = true
                    }
                }
                .sheet(isPresented: $showingAddPerson) {
                    AddPersonView(people: $people, location: locationFetcher.lastKnownLocation ?? nil)
                }
        }
        .onAppear {
            if people.isEmpty {
                loadPeople()
            }
            
            locationFetcher.start()
        }
    }
    
    func loadPeople() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Person].self, from: data)
        } catch {
            people = []
        }
    }
}

#Preview {
    ContentView()
}

