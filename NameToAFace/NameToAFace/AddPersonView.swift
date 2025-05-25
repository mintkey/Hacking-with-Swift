//
//  AddPersonView.swift
//  NameToAFace
//
//  Created by Helen Dempsey on 5/25/25.
//

import PhotosUI
import SwiftUI

struct AddPersonView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var name: String = ""
    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedItem) {
                Text("Select photo")
            }
            TextField("Name of person", text: $name)
        }
    }
}

#Preview {
    AddPersonView()
}
