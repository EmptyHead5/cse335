//
//  JapanView.swift
//  Lab 2
//
//  Created by zenanchang on 2/3/26.
//

import SwiftUI

struct JapanView: View {
    @Binding var remainingUSD: Double
    @Binding var path: NavigationPath
    @Binding var stringFromJap :  String
    
    @State private var Spend = 0.0
    @State private var yanSpend = 0.0
    var stringFromFirst : String
    
    
    var body: some View {
        VStack{
            
            Text(flag(country: "JP"))
                .font(.largeTitle)
            Text(stringFromFirst)
                .foregroundColor(.pink)
            HStack{
                Text("Expenditure in yen: ")
                TextField("",value: $Spend,format: .number)
                
            }
                Button("Calculate")
            {
                yanSpend = Spend / 110
                remainingUSD -= yanSpend
            }
            .buttonStyle(.borderedProminent)
            
            Text("Remaining funds: $" + String(remainingUSD))
            HStack{
                Button("Go to Europe")
                {
                    path.removeLast()
                }
                .buttonStyle(.borderedProminent)
                Button("GO to USA")
                {
                    stringFromJap = "Coming back from a foreign land."
                    path.removeLast(path.count)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        
    }
}
