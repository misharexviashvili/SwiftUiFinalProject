import SwiftUI
import SwiftData

struct ExpenseListSection: View {
    let expenses: [Expense]
    let hasAnyExpenses: Bool
    let selectedCategory: ExpenseCategory?
    
    var body: some View {
        Section("ხარჯები") {
            if !hasAnyExpenses {
                ContentUnavailableView(
                    "ხარჯები არ არის",
                    systemImage: "tray",
                    description: Text("ჯერ არცერთი ხარჯი არ დაგიმატებიათ.")
                )
            } else if expenses.isEmpty {
                ContentUnavailableView(
                    "შედეგი ვერ მოიძებნა",
                    systemImage: "line.3.horizontal.decrease.circle",
                    description: Text("კატეგორიაში „\(selectedCategory?.rawValue ?? "")“ ხარჯები არ არის.")
                )
            } else {
                ForEach(expenses) { expense in
                    ExpenseRow(expense: expense)
                }
            }
        }
    }
}

#Preview {
    List {
        ExpenseListSection(expenses: Expense.sampleData, hasAnyExpenses: true, selectedCategory: nil)
    }
    .modelContainer(Expense.previewContainer)
}
