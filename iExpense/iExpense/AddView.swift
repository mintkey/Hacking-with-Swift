//
//  AddView.swift
//  iExpense
//
//  Created by Helen Dempsey on 4/19/25.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var name = "New expense"
    @State private var type = "Personal"
    @State private var currencyCode = "USD"
    @State private var amount = 0.0
    let currencyCodes = ["USD", "CAD", "EUR", "GBP", "JPY", "KRW"]

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Currency", selection: $currencyCode) {
                    ForEach(currencyCodes, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)

                TextField("Amount", value: $amount, format: .currency(code: currencyCode))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let expense = Expense(name: name, type: type, currencyCode: currencyCode, amount: amount)
                        modelContext.insert(expense)
                        
                        dismiss()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AddView()
}
