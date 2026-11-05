//
//  AddExpenseView.swift
//  SwiftUiFinalProject
//
//  Created by Misha on 05.11.2026.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    
    let onSave: (Expense) -> Void
    
    @State private var name = ""
    @State private var amountText = ""
    @State private var category: ExpenseCategory = .food
    @State private var date = Date()
    @State private var errorMessage: String?
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
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
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            errorMessage = "გთხოვთ, შეიყვანოთ ხარჯის დასახელება."
            return
        }
        
        let normalizedAmount = amountText
            .trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: ",", with: ".")
        guard !normalizedAmount.isEmpty else {
            errorMessage = "გთხოვთ, შეიყვანოთ თანხა."
            return
        }
        guard let amount = Double(normalizedAmount), amount.isFinite else {
            errorMessage = "თანხა უნდა იყოს რიცხვი, მაგ. 12.50"
            return
        }
        guard amount > 0 else {
            errorMessage = "თანხა უნდა იყოს ნულზე მეტი."
            return
        }
        
        let expense = Expense(
            name: trimmedName,
            amount: amount,
            category: category.rawValue,
            date: Self.dateFormatter.string(from: date)
        )
        onSave(expense)
        dismiss()
    }
}

#Preview {
    AddExpenseView { _ in }
}
