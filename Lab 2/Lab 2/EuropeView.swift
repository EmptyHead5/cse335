//
//  EuropeView.swift
//  Lab 2
//
//  Created by zenanchang on 2/3/26.
//

import SwiftUI

struct EuropeView: View {
    @State private var spendEur = 0.0
    @State private var eurSpend = 0.0
    @State var value = 0.0

    var stringFromFirst : String
    @Binding var remainingUSD: Double
    @Binding var path: NavigationPath

    var body: some View {
        VStack {
            Text("Europe")
                .font(.title)

            Text(stringFromFirst)
                .foregroundColor(.green)

            Text(flag(country: "EU"))
                .font(.system(size: 100))


            HStack {
                Text("Expenditure in EUR")
                TextField("Enter amount", value: $spendEur, format: .number)
                    .textFieldStyle(.roundedBorder)
            }

            
            
            Button("Calculate") {
                eurSpend = spendEur / 0.85
                remainingUSD -= eurSpend
            }
            .buttonStyle(.borderedProminent)
            
            Text("Remaining Budget: $\(remainingUSD, specifier: "%.2f")")
            HStack{
                NavigationLink("Visit Japen", value:"Japan")
                    .buttonStyle(.borderedProminent)
                Button("Go to USA") {
                    path.removeLast()
                }
                .buttonStyle(.borderedProminent)
            }

        }
        .padding()
    }
}

