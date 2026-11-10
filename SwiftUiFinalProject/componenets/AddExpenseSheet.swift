//
//  AddExpenseView.swift
//  SwiftUiFinalProject
//
//  Created by Misha on 05.11.2026.
//

import SwiftUI

struct AddExpenseSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    let onSave: (Expense) -> Void
    
    @State private var name = ""
    @State private var amountText = ""
    @State private var category: ExpenseCategory = .food
    @State private var date = Date()
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("დასახელება") {
                    TextField("დასახელება", text: $name)
                }
                
                Section("თანხა") {
                    HStack {
                        TextField("0.00", text: $amountText)
                            .keyboardType(.decimalPad)
                        Text("₾")
                            .foregroundStyle(.secondary)
                    }
                }
                
                Section("კატეგორია") {
                    Picker("კატეგორია", selection: $category) {
                        ForEach(ExpenseCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                }
                
                Section("თარიღი") {
                    DatePicker("თარიღი", selection: $date, displayedComponents: .date)
                }
                
                if let errorMessage {
                    Section {
                        Label(errorMessage, systemImage: "exclamationmark.triangle.fill")
                            .foregroundStyle(.red)
                    }
                }
                
                Section {
                    HStack {
                        Button("გაუქმება", role: .cancel) {
                            dismiss()
                        }
                        .buttonStyle(.bordered)
                        
                        Spacer()
                        
                        Button("შენახვა") {
                            save()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .listRowBackground(Color.clear)
            }
            .navigationTitle("ახალი ხარჯი")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("დახურვა") {
                        dismiss()
                    }
                }
            }
            .onChange(of: name) { errorMessage = nil }
            .onChange(of: amountText) { errorMessage = nil }
        }
    }
    
    private func save() {
        switch ExpenseValidator.validate(name: name, amountText: amountText) {
        case .success(let input):
            let expense = Expense(
                name: input.name,
                amount: input.amount,
                category: category.rawValue,
                date: date
            )
            onSave(expense)
            dismiss()
        case .failure(let error):
            errorMessage = error.message
        }
    }
}

#Preview {
    AddExpenseSheet { _ in }
}
