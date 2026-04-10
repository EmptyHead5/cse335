//
//  ContentView.swift
//  Lab 7
//
//  Created by zenanchang on 4/10/26.
//

import SwiftUI
import UIKit
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var cities: [City]
    @State private var showAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(cities) { city in
                    NavigationLink {
                        CityDetailView(city: city)
                    } label: {
                        HStack(spacing: 12) {
                            if let uiImage = UIImage(data: city.pictureData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                    .cornerRadius(8)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(city.name)
                                    .font(.headline)
                                Text(city.cityDescription)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            modelContext.delete(city)
                            try? modelContext.save()
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("My Travel Journal")
            .toolbar {
                Button {
                    showAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddView) {
                addCityView()
            }
        }
    }
}

#Preview {
    ContentView()
}
