//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Helen Dempsey on 5/3/25.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            loadData()
        }
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(order) {
            UserDefaults.standard.set(data, forKey: "SavedAddress")
        }
    }
        
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "SavedAddress") {
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                order.name = decodedOrder.name
                order.streetAddress = decodedOrder.streetAddress
                order.city = decodedOrder.city
                order.zip = decodedOrder.zip
            }
        }
    }
}

#Preview {
    AddressView(order: Order())
}
