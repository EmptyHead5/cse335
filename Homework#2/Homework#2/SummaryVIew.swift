//
//  SummaryVIew.swift
//  Homework#1
//
//  Created by zenanchang on 3/27/26.
//

import SwiftUI
import Charts
import SwiftData

struct SummaryView: View {
    @ObservedObject var viewModel: FinanceViewModel
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \FinanceRecord.date, order: .reverse) private var records: [FinanceRecord]
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                FinanceCard(title: "Income", value: String(viewModel.totalIncome(from: records)), color: .green)
                FinanceCard(title: "Expenses", value: String(viewModel.totalExpenses(from: records)), color: .red)
                FinanceCard(title: "Savings", value: String(viewModel.totalSavings(from: records)), color: .blue)
            }
            let status = viewModel.financeStatusMessage(from: records)


            Text(status.message)
                .foregroundColor(status.color)
            List {
                ForEach(records, id: \.id) { record in
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Category: \(record.date)")
                        Text("Category: \(record.category)")
                        Text("Income: $\(record.income)")
                        Text("Expenses: $\(record.expenses)")
                        Text("Savings: $\(record.savings)")
                    }
                    .padding(.vertical, 6)
                }
            }
           Chart
            {
                ForEach(records, id: \.id) { record in
                    BarMark(
                        x: .value("Category", record.category),
                        y: .value("Expenses", record.expenses)
                    )
                }
            }
        }
    }
}

