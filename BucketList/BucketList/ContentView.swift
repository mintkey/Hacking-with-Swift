//
//  ContentView.swift
//  BucketList
//
//  Created by Helen Dempsey on 5/18/25.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    @State private var mapTypeSelected = "Standard"
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack(alignment: .topTrailing) {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(mapTypeSelected == "Standard" ? .standard : .hybrid)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        Text(place.name)
                        
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                }
                
                Button(mapTypeSelected == "Standard" ? "Switch to Hybrid" : "Switch to Standard") {
                    mapTypeSelected == "Standard" ? (mapTypeSelected = "Hybrid") : (mapTypeSelected = "Standard")
                }
                .padding(10)
                .background(.gray)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
            }
        } else {
            VStack {
                Button("Unlock Places", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
            .alert("Authentication error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.alertMessage)
            }
        }
    }
}

#Preview {
    ContentView()
}
