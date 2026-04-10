//
//  ContentView.swift
//  Homework#1
//
//  Created by zenanchang on 3/27/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = FinanceViewModel()
    @Environment(\.modelContext) private var modelContext
    @State private var showDateAlert = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Personal Finance Tracker")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    
                    VStack() {
                        Text("Enter Financial Data")
                            .font(.title2)
                            .fontWeight(.semibold)

                        TextField("Total Income", text: $viewModel.income)
                            .textFieldStyle(.roundedBorder)
                        
                        TextField("Total Expenses", text: $viewModel.expenses)
                            .textFieldStyle(.roundedBorder)
                            

                        TextField("Savings for the Day", text: $viewModel.savings)
                            .textFieldStyle(.roundedBorder)

                        Picker("Expense Category", selection: $viewModel.selectedCategory) {
                            ForEach(viewModel.categories, id: \.self) { category in
                                Text(category)
                            }
                        }
                        .pickerStyle(.menu)
                        DatePicker("Date", selection: $viewModel.selectedDate, displayedComponents: .date)

                        Button {
                            viewModel.saveData(context: modelContext)
                        }
                        label: {
                            Text("Save Data")
                        }
                        .buttonStyle(.borderedProminent)

                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .shadow(radius: 3)
                    .padding(.horizontal)

                    NavigationStack {
                        NavigationLink {
                            SummaryView(viewModel: viewModel)
                        } label: {
                            Text("Recent 7 Days")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .alert("Error",isPresented: $viewModel.showAlert)
                    {
                        Button("OK", role: .cancel) { }
                    }message:
                    {
                        Text(viewModel.alertMessage)
                    }
                }
                .padding(.bottom)
            }
        }
    }
}



