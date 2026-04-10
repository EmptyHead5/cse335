//
//  FinanceVIew.swift
//  Homework#1
//
//  Created by zenanchang on 3/27/26.
//

import Combine
import SwiftUI
import SwiftData

class FinanceViewModel: ObservableObject {
    @Published var income: String = ""
    @Published var expenses: String = ""
    @Published var savings: String = ""
    @Published var selectedCategory: String = "Food"
    @Published var selectedDate: Date = Date()
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    let categories = ["Food", "Entertainment", "Transportation", "Rent/Mortgage", "Miscellaneous"]

    func saveData(context: ModelContext) {
        let incomeValue = Double(income) ?? 0
        let expensesValue = Double(expenses) ?? 0
        let savingsValue = Double(savings) ?? 0

        guard let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) else {
            alertMessage = "Could not calculate the 7-day limit."
            showAlert = true
            return
        }

        guard selectedDate >= sevenDaysAgo else {
            alertMessage = "You can only save records for the past 7 days. Please select a more recent date."
            showAlert = true
            return
        }

        let newRecord = FinanceRecord(
            date: selectedDate,
            income: incomeValue,
            expenses: expensesValue,
            savings: savingsValue,
            category: selectedCategory
        )

        context.insert(newRecord)

        do {
            try context.save()
        } catch {
            alertMessage = "Failed to save record."
            showAlert = true
            print(error)
            return
        }

        income = ""
        expenses = ""
        savings = ""
        selectedCategory = "Food"
    }

    func deletAllRecords(context: ModelContext) {
        do{
        let allRecord = try context.fetch(FetchDescriptor<FinanceRecord>())
        
            for record in allRecord {
                context.delete(record)
            }
        }
        catch
        {
            print("Failed to delete all records: \(error)")
        }
    }
    

    func totalIncome(from records: [FinanceRecord]) -> Double {
        records.reduce(0) { $0 + $1.income }
    }

    func totalExpenses(from records: [FinanceRecord]) -> Double {
        records.reduce(0) { $0 + $1.expenses }
    }

    func totalSavings(from records: [FinanceRecord]) -> Double {
        records.reduce(0) { $0 + $1.savings }
    }

    func financeStatusMessage(from records: [FinanceRecord]) -> (message: String, color: Color) {
        let incomeTotal = totalIncome(from: records)
        let expenseTotal = totalExpenses(from: records)
        let savingsTotal = totalSavings(from: records)

        guard incomeTotal > 0 else {
            return ("Enter income to see your status.", .gray)
        }

        let expenseRatio = expenseTotal / incomeTotal
        let savingsRatio = savingsTotal / incomeTotal

        if expenseRatio > 0.30 {
            return ("You are overspending!", .red)
        } else if savingsRatio >= 0.10 && savingsRatio <= 0.30 {
            return ("You have a balanced budget!", .orange)
        } else if savingsRatio > 0.30 {
            return ("You are saving well!", .green)
        } else {
            return ("Keep tracking your spending!", .gray)
        }
    }
}
