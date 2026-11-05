//
//  ContentView.swift
//  SwiftUiFinalProject
//
//  Created by Misha on 03.11.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses: [Expense]
    @State private var isAddingExpense = false
    
    init(expenses: [Expense] = Expense.sampleData) {
        _expenses = State(initialValue: expenses)
    }
    
    private var totalAmount: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("ამ თვის ხარჯი")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text("ჯამი: \(formatAmount(totalAmount))")
                            .font(.title.bold())
                    }
                    .padding(.vertical, 4)
                }
                
                Section("ხარჯები") {
                    if expenses.isEmpty {
                        ContentUnavailableView(
                            "ხარჯები არ არის",
                            systemImage: "tray",
                            description: Text("ჯერ არცერთი ხარჯი არ დაგიმატებიათ.")
                        )
                    } else {
                        ForEach(expenses) { expense in
                            ExpenseRow(expense: expense)
                        }
                    }
                }
            }
            .navigationTitle("ჩემი ბიუჯეტი")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isAddingExpense = true
                    } label: {
                        Label("ხარჯის დამატება", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingExpense) {
                AddExpenseView { expense in
                    expenses.append(expense)
                }
            }
        }
    }
}



func formatAmount(_ amount: Double) -> String {
    String(format: "%.2f ₾", amount)
}

#Preview("ხარჯებით") {
    ContentView()
}

#Preview("ცარიელი სია") {
    ContentView(expenses: [])
}
