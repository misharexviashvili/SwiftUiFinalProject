import Foundation

enum ExpenseValidationError: Error {
    case emptyName
    case emptyAmount
    case invalidAmount
    case nonPositiveAmount
    
    var message: String {
        switch self {
        case .emptyName: "გთხოვთ, შეიყვანოთ ხარჯის დასახელება."
        case .emptyAmount: "გთხოვთ, შეიყვანოთ თანხა."
        case .invalidAmount: "თანხა უნდა იყოს რიცხვი, მაგ. 12.50"
        case .nonPositiveAmount: "თანხა უნდა იყოს ნულზე მეტი."
        }
    }
}

struct ValidatedExpenseInput {
    let name: String
    let amount: Double
}

enum ExpenseValidator {
    static func validate(name: String, amountText: String) -> Result<ValidatedExpenseInput, ExpenseValidationError> {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            return .failure(.emptyName)
        }
        
        let normalizedAmount = amountText
            .trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: ",", with: ".")
        guard !normalizedAmount.isEmpty else {
            return .failure(.emptyAmount)
        }
        guard let amount = Double(normalizedAmount), amount.isFinite else {
            return .failure(.invalidAmount)
        }
        guard amount > 0 else {
            return .failure(.nonPositiveAmount)
        }
        
        return .success(ValidatedExpenseInput(name: trimmedName, amount: amount))
    }
}
