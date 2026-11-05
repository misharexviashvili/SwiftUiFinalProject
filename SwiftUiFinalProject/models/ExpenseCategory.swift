//
//  ExpenseCategory.swift
//  SwiftUiFinalProject
//
//  Created by Misha on 05.11.2026.
//

import Foundation

enum ExpenseCategory: String, CaseIterable, Identifiable {
    case food = "საკვები"
    case transport = "ტრანსპორტი"
    case entertainment = "გართობა"
    case other = "სხვა"
    
    var id: String { rawValue }
}
