import Foundation

extension Array where Element == Expense {
    func filtered(by category: ExpenseCategory?) -> [Expense] {
        guard let category else { return self }
        return filter { $0.category == category.rawValue }
    }
    
    var totalAmount: Double {
        reduce(0) { $0 + $1.amount }
    }
}
