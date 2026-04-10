//
//  ContentView.swift
//  Lab 2
//
//  Created by zenanchang on 2/3/26.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    @State private var hasReturned = false
    @State private var stringToEur = ""
    @State private var stringFromJap=""
    
    @State var usDollar: Double = 0.0

    var body: some View {
        NavigationStack(path: $path) {
            VStack{
                Text("You are in the USA")
                    .font(.title)
                Text(flag(country: "US"))
                    .font(.system(size: 120))
                
                if !stringFromJap.isEmpty{
                    Text(stringFromJap)
                        .foregroundColor(.blue)
                }
                
                HStack {
                    Text("Total Budget (USD): $ ")
                    TextField("", value: $usDollar, format: .number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button("Visit Europe") {
                    path.append("Europe")
                    
                }
                .buttonStyle(.borderedProminent)

            }
            .navigationDestination(for: String.self) {value in
                if value == "Europe"
                {
                    EuropeView(stringFromFirst: "A bit more valuable here !",remainingUSD: $usDollar, path: $path)
   
                }
                else if value == "Japan"
                {
                    JapanView(remainingUSD: $usDollar,path: $path, stringFromJap: $stringFromJap,stringFromFirst:"I feel rick!")
                }
            }


        }
    }
}

