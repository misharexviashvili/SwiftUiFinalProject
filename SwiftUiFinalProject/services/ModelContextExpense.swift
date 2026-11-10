import SwiftData

extension ModelContext {
    func addExpense(_ expense: Expense) throws {
        insert(expense)
        do {
            try save()
        } catch {
            delete(expense)
            throw error
        }
    }
}
