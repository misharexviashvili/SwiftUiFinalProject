import Foundation
import SwiftData

extension Expense {
    static var sampleData: [Expense] {
        let calendar = Calendar.current
        let today = Date()
        return [
            Expense(name: "სადილი", amount: 25.00, category: ExpenseCategory.food.rawValue, date: today),
            Expense(name: "ავტობუსი", amount: 2.00, category: ExpenseCategory.transport.rawValue, date: calendar.date(byAdding: .day, value: -1, to: today) ?? today),
            Expense(name: "კინო", amount: 30.00, category: ExpenseCategory.entertainment.rawValue, date: calendar.date(byAdding: .day, value: -2, to: today) ?? today)
        ]
    }
    
    @MainActor
    static var previewContainer: ModelContainer {
        let container = try! ModelContainer(
            for: Expense.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        for expense in sampleData {
            container.mainContext.insert(expense)
        }
        return container
    }
}
