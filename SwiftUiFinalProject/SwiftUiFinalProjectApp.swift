//
//  SwiftUiFinalProjectApp.swift
//  SwiftUiFinalProject
//
//  Created by Misha on 03.11.2026.
//

import SwiftUI
import SwiftData

@main
struct SwiftUiFinalProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
