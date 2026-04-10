//
//  Homework_1App.swift
//  Homework#1
//
//  Created by zenanchang on 3/27/26.
//

import SwiftUI
import SwiftData

@main
struct Homework2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: FinanceRecord.self)
    }
}
