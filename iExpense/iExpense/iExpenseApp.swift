//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Helen Dempsey on 4/18/25.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
