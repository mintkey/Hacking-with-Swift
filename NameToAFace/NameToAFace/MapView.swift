//
//  MapView.swift
//  NameToAFace
//
//  Created by Helen Dempsey on 5/30/25.
//

import MapKit
import SwiftUI

struct MapView: View {
    let latitude: Double
    let longitude: Double
    let position: MapCameraPosition

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
        )
        
        self.position = .region(region)
    }
    
    var body: some View {
        Map(initialPosition: position)
            .frame(height: 300)
    }
}

#Preview {
    MapView(latitude: 32.6514, longitude: -161.4333)
}
