//
//  ContentView.swift
//  SwiftUiFinalProject
//
//  Created by Misha on 03.11.2026.
//

import SwiftUI

struct ContentView: View {
    let expenses: [Expense]
    
    init(expenses: [Expense] = Expense.sampleData) {
        self.expenses = expenses
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
        }
    }
}



func formatAmount(_ amount: Double) -> String {
    String(format: "%.2f ₾", amount)
}

func formatDate(_ date: Date) -> String {
    date.formatted(.dateTime.day().month(.wide).locale(Locale(identifier: "ka_GE")))
}

#Preview("ხარჯებით") {
    ContentView()
}

#Preview("ცარიელი სია") {
    ContentView(expenses: [])
}
