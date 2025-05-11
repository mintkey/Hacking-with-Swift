//
//  Expenses.swift
//  iExpense
//
//  Created by Helen Dempsey on 5/10/25.
//

import Foundation
import SwiftData

@Model
class Expense {
    var name: String
    var type: String
    var currencyCode: String
    var amount: Double
    
    init(name: String, type: String, currencyCode: String, amount: Double) {
        self.name = name
        self.type = type
        self.currencyCode = currencyCode
        self.amount = amount
    }
}
