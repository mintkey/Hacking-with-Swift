//
//  EditView.swift
//  BucketList
//
//  Created by Helen Dempsey on 5/20/25.
//

import SwiftUI

enum LoadingState {
    case loading, loaded, failed
}

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: ViewModel
    var onSave: (Location) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    onSave(viewModel.addNewLocation())
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        _viewModel = State(initialValue: ViewModel(location: location, name: location.name, description: location.description))
        self.onSave = onSave
    }
}

#Preview {
    EditView(location: .example) { _ in }
}
