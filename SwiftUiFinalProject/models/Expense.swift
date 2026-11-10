//
//  Expense.swift
//  SwiftUiFinalProject
//
//  Created by Misha on 03.11.2026.
//

import Foundation
import SwiftData

@Model
final class Expense {
    var id: UUID
    var name: String
    var amount: Double
    var category: String
    var date: Date
    
    init(name: String, amount: Double, category: String, date: Date) {
        self.id = UUID()
        self.name = name
        self.amount = amount
        self.category = category
        self.date = date
    }
}
