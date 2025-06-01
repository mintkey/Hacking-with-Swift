//
//  Person.swift
//  NameToAFace
//
//  Created by Helen Dempsey on 5/26/25.
//

import Foundation
import MapKit
import Observation
import SwiftUI

@Observable
class Person: Codable, Identifiable, Comparable {
    var id: UUID
    var faceFilename: String
    var name: String
    
    var latitude: Double
    var longitude: Double
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(id: UUID = UUID(), faceFilename: String, name: String, latitude: Double, longitude: Double) {
        self.id = id
        self.faceFilename = faceFilename
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }

    var faceImage: Image? {
        let url = FileManager.documentsDirectory.appendingPathComponent(faceFilename)
        
        if let uiImage = UIImage(contentsOfFile: url.path) {
            return Image(uiImage: uiImage)
        }
        
        return nil
    }

    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }

    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
}
