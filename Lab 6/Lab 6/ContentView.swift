//
//  ContentView.swift
//  Lab 6
//
//  Created by zenanchang on 3/27/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var api = GeonamesAPI()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("GroNames City List")
                    .font(.largeTitle.bold())
                
                Button {
                    api.analyze()
                }
                label: {
                    Text("Load Cities")
                }
                .buttonStyle(.borderedProminent)
                
                
                List(api.cities) { city in
                    NavigationLink {
                        MapView(city: city)
                    } label: {
                        VStack{
                            Text(city.name)
                                .font(.headline)
                            Text(String(city.population))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text(city.countrycode)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
