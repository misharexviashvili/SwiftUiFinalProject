//
//  Expense.swift
//  SwiftUiFinalProject
//
//  Created by Misha on 03.11.2026.
//

import Foundation

class Expense: Identifiable {
    let id = UUID()
    var name: String
    var amount: Double
    var category: String
    var date: String
    
    init(name: String, amount: Double, category: String, date: String) {
        self.name = name
        self.amount = amount
        self.category = category
        self.date = date
    }
}

extension Expense {
    static let sampleData: [Expense] = [
        Expense(name: "სადილი", amount: 25.00, category: "საკვები", date: "01.01.2026"),
        Expense(name: "ავტობუსი", amount: 2.00, category: "ტრანსპორტი", date: "02.01.2026"),
        Expense(name: "კინო", amount: 30.00, category: "გართობა", date: "03.01.2026")
    ]
}


