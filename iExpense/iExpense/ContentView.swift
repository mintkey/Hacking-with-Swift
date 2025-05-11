//
//  ContentView.swift
//  iExpense
//
//  Created by Helen Dempsey on 4/18/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount),
    ]
    @State private var expenseType = "All"
    let expenseTypes = ["All", "Business", "Personal"]
    
    
    var body: some View {
        NavigationStack {
            ExpensesView(filterByExpenseType: expenseType, sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView()
                } label: {
                    Image(systemName: "plus")
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\Expense.name),
                                SortDescriptor(\Expense.amount),
                            ])

                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\Expense.amount),
                                SortDescriptor(\Expense.name)
                            ])
                    }
                }
                
                Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                    Picker("Filter", selection: $expenseType) {
                        ForEach(expenseTypes, id: \.self) { type in Text(type)
                        }
                    }
                }
            }
        }
    }
    
    func removeExpenses(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]

            modelContext.delete(expense)
        }
    }
}

struct ExpenseStyle: ViewModifier {
    var expense: Expense
    
    func body(content: Content) -> some View {
        switch expense.amount {
        case 0..<10: content.foregroundStyle(.green)
        case 10..<100: content.foregroundStyle(.yellow)
        case 100...: content.foregroundStyle(.red)
        default: content.foregroundStyle(.black)
        }
    }
}

extension View {
    func expenseStyle(_ expense: Expense) -> some View {
        modifier(ExpenseStyle(expense: expense))
    }
}

#Preview {
    ContentView()
}
