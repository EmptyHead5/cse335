//
//  Lab_7App.swift
//  Lab 7
//
//  Created by zenanchang on 4/10/26.
//

import SwiftUI
import SwiftData

@main
struct Lab_7App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: City.self)
    }
}
