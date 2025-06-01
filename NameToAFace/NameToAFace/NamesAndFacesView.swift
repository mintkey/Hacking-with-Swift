//
//  NamesAndFacesView.swift
//  NameToAFace
//
//  Created by Helen Dempsey on 5/25/25.
//

import MapKit
import SwiftUI

struct NamesAndFacesView: View {
    var people: [Person]
    
    var body: some View {
        List{
            ForEach(people.sorted { $0.name < $1.name }) { person in
                NavigationLink(destination: DetailView(person: person)) {
                    HStack {
                        faceImage(for: person)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.primary, lineWidth: 1))
                            .shadow(radius: 3)

                        Text(person.name)
                            .font(.headline)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
    
    func faceImage(for person: Person) -> Image {
        let imageURL = URL.documentsDirectory.appendingPathComponent(person.faceFilename)
        if let uiImage = UIImage(contentsOfFile: imageURL.path) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.crop.circle.badge.exclam")
        }
    }
}

#Preview {
    let examplePerson = Person(
        id: UUID(),
        faceFilename: "example.jpg",
        name: "Test User",
        latitude: 32.6514,
        longitude: -161.4333
    )
    
    NamesAndFacesView(people: [examplePerson])
}
