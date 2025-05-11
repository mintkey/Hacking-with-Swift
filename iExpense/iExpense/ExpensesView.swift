//
//  ExpensesView.swift
//  iExpense
//
//  Created by Helen Dempsey on 5/10/25.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text(expense.name)
                            .font(.headline)
                    }
                    
                    Spacer()
                    
                    Text(expense.amount, format: .currency(code: expense.currencyCode))
                        .expenseStyle(expense)
                }
            }
            .onDelete(perform: removeExpenses)
        }
    }
    
    init(filterByExpenseType: String, sortOrder: [SortDescriptor<Expense>]) {
        _expenses = Query(filter: #Predicate<Expense> { expense in
            if filterByExpenseType == "All" {
                expense.type == "Personal" || expense.type == "Business"
            } else if filterByExpenseType == "Personal" {
                expense.type == "Personal"
            } else {
                expense.type == "Business"
            }
        }, sort: sortOrder)
    }
    
    func removeExpenses(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]

            modelContext.delete(expense)
        }
    }
}

#Preview {
    ExpensesView(filterByExpenseType: "Personal", sortOrder: [SortDescriptor(\Expense.name)])
        .modelContainer(for: Expense.self)
}
