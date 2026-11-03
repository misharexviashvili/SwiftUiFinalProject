//
//  ExpenseRow.swift
//  SwiftUiFinalProject
//
//  Created by Misha on 03.11.2026.
//

import SwiftUI

struct ExpenseRow: View {
    let expense: Expense
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.name)
                    .font(.headline)
                Text(expense.date)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(formatAmount(expense.amount))
                .font(.headline)
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    ExpenseRow(expense: Expense.init(name: "ბილიარდი", amount: 12, category: "სპორტი", date: "04.01.2026"))
}
