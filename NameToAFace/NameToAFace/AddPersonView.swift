//
//  AddPersonView.swift
//  NameToAFace
//
//  Created by Helen Dempsey on 5/25/25.
//

import MapKit
import PhotosUI
import SwiftUI

struct AddPersonView: View {
    @Binding var people: [Person]
    @Environment(\.dismiss) var dismiss
    @State private var selectedItem: PhotosPickerItem?
    @State private var image: Image?
    @State private var name: String = ""
    @State private var imageData: Data?
    
    let savePath = URL.documentsDirectory.appendingPathComponent("SavedPeople")
    
    var location: CLLocationCoordinate2D?
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedItem, matching: .images) {
                if let image {
                    VStack {
                        image
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                } else {
                    ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Select an image"))
                }
            }
            .buttonStyle(.plain)
            .onChange(of: selectedItem) {
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        imageData = data
                        image = Image(uiImage: uiImage)
                    } else {
                        print("Failed to load image")
                    }
                }
            }
            
            Form {
                Section {
                    TextField("Name of person", text: $name)
                }
                
                Section {
                    Button("Save") {
                        addPerson()
                    }
                    .disabled(name.isEmpty || imageData == nil)
                }
            }
        }
        .background(Color(UIColor.systemGray6))
        .navigationTitle("Add Person")
    }
    
    
    
    func addPerson() {
        guard let imageData else { return }

        let id = UUID()
        let filename = "\(id).jpg"
        let imageURL = URL.documentsDirectory.appendingPathComponent(filename)

        do {
            try imageData.write(to: imageURL, options: [.atomic, .completeFileProtection])
            let newPerson = Person(id: id, faceFilename: filename, name: name, latitude: location?.latitude ?? 0.0, longitude: location?.longitude ?? 0.0)
            people.append(newPerson)
            save()
            dismiss()
        } catch {
            print("Failed to save image")
        }
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}

#Preview {
    AddPersonView(people: .constant([]), location: nil)
}
