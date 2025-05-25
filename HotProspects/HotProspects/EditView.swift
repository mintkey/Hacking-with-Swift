//
//  EditView.swift
//  HotProspects
//
//  Created by Helen Dempsey on 5/25/25.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var updatedName = ""
    @State private var updatedEmailAddress = ""
    var prospect: Prospect
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $updatedName)
                    TextField("Email address", text: $updatedEmailAddress)
                }
            }
            .navigationTitle("Prospect Info")
            .toolbar {
                Button("Update") {
                    prospect.name = updatedName
                    prospect.emailAddress = updatedEmailAddress
                    
                    dismiss()
                }
            }
            .onAppear {
                updatedName = prospect.name
                updatedEmailAddress = prospect.emailAddress
            }
        }
    }
}

#Preview {
    let sampleProspect = Prospect(name: "John Doe", emailAddress: "johndoe@example.com", isContacted: true)
    EditView(prospect: sampleProspect)
}
