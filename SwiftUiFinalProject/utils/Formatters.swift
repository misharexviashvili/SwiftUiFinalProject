import Foundation

func formatAmount(_ amount: Double) -> String {
    String(format: "%.2f ₾", amount)
}

func formatDate(_ date: Date) -> String {
    date.formatted(Date.FormatStyle(date: .long, time: .omitted).locale(Locale(identifier: "ka_GE")))
}
