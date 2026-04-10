//
//  ContentView.swift
//  Lab 5
//
//  Created by zenanchang on 3/20/26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = ParkViewModel()
    @State private var showAddView = false
    
    private var groupedParks: [String: [Park]] {
        Dictionary(grouping: viewModel.parks) { park in
            String(park.name.prefix(1)).uppercased()
        }
    }
    
    private var sortedKeys: [String] {
        groupedParks.keys.sorted()
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedKeys, id: \.self) { key in
                    Section(header: Text(key)) {
                        ForEach(groupedParks[key] ?? []) { park in
                            NavigationLink {
                                ParkDetailView(park: park)
                            } label: {
                                HStack {
                                    Image(park.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipped()
                                        .cornerRadius(8)
                                    
                                    VStack(alignment: .leading) {
                                        Text(park.name)
                                            .foregroundStyle(.primary)
                                        
                                        Text(park.location)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    
                                    Spacer()
                                }
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.deletePark(park)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Parks")
            .toolbar {
                Button {
                    showAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddView) {
                AddParkView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
