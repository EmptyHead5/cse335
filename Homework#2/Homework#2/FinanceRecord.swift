//
//  FinanceRecord.swift
//  Homework#2
//
//  Created by zenanchang on 4/10/26.
//

import Foundation
import SwiftData

@Model
final class FinanceRecord {
    var id: UUID
    var date: Date
    var income: Double
    var expenses: Double
    var savings: Double
    var category: String

    init(date: Date, income: Double, expenses: Double, savings: Double, category: String) {
        self.id = UUID()
        self.date = date
        self.income = income
        self.expenses = expenses
        self.savings = savings
        self.category = category
    }
}
