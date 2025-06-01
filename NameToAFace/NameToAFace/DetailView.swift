//
//  DetailView.swift
//  NameToAFace
//
//  Created by Helen Dempsey on 5/26/25.
//

import MapKit
import SwiftUI

struct DetailView: View {
    var person: Person
    
    var body: some View {
        VStack(alignment: .leading) {
            faceImage(for: person)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 300, alignment: .center)
            
            Spacer()
            
            if (person.latitude != 0 && person.longitude != 0) {
                    Text("Seen at")
                        .font(.title3.bold())
                        
                MapView(latitude: person.latitude, longitude: person.longitude)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .navigationTitle(person.name)
        .padding()
    }

    func faceImage(for person: Person) -> Image {
        let imageURL = URL.documentsDirectory.appendingPathComponent(person.faceFilename)
        if let uiImage = UIImage(contentsOfFile: imageURL.path) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "exclamationmark.triangle")
        }
    }
}

#Preview {
    let samplePerson = Person(
        id: UUID(),
        faceFilename: "example.jpg",
        name: "Preview Name",
        latitude: 32.6514,
        longitude: -161.4333
    )
    
    DetailView(person: samplePerson)
}
