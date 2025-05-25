//
//  ContentView.swift
//  NameToAFace
//
//  Created by Helen Dempsey on 5/24/25.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import StoreKit
import SwiftUI
import PhotosUI

struct ContentView: View {
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.25
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilters = false
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            NamesAndFacesView()
                .navigationTitle("Name to a Face")
                .toolbar {
                    NavigationLink {
                        AddPersonView()
                    } label: {
                        Text("Add person")
                    }
                    
                }
        }
    }
}

#Preview {
    ContentView()
}

