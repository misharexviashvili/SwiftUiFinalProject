//
//  ContentView.swift
//  SwiftUiFinalProject
//
//  Created by Misha on 03.11.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Expense.date, order: .reverse) private var expenses: [Expense]
    @State private var isAddingExpense = false
    @State private var selectedCategory: ExpenseCategory?
    @State private var saveErrorMessage: String?
    
    private var filteredExpenses: [Expense] {
        expenses.filtered(by: selectedCategory)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TotalSummaryView(
                        title: selectedCategory?.rawValue ?? "ყველა ხარჯი",
                        total: filteredExpenses.totalAmount
                    )
                }
                
                Section {
                    CategoryFilterBar(selectedCategory: $selectedCategory)
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                
                ExpenseListSection(
                    expenses: filteredExpenses,
                    hasAnyExpenses: !expenses.isEmpty,
                    selectedCategory: selectedCategory
                )
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
                AddExpenseSheet { expense in
                    addExpense(expense)
                }
            }
            .alert(
                "შენახვა ვერ მოხერხდა",
                isPresented: Binding(
                    get: { saveErrorMessage != nil },
                    set: { if !$0 { saveErrorMessage = nil } }
                )
            ) {
                Button("კარგი", role: .cancel) {}
            } message: {
                Text(saveErrorMessage ?? "")
            }
        }
    }
    
    private func addExpense(_ expense: Expense) {
        do {
            try modelContext.addExpense(expense)
        } catch {
            saveErrorMessage = "ხარჯის შენახვისას მოხდა შეცდომა. სცადეთ თავიდან."
        }
    }
}

#Preview("ხარჯებით") {
    ContentView()
        .modelContainer(Expense.previewContainer)
}

#Preview("ცარიელი სია") {
    ContentView()
        .modelContainer(for: Expense.self, inMemory: true)
}
