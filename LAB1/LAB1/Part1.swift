//
//  ContentView.swift
//  LAB1
//
//  Created by zenanchang on 1/25/26.
//

import SwiftUI

struct Part1: View {
    @State private var gender: Gender = .female
    @State var weight: String = ""
    @State var height: String = ""
    @State var idealWeight: Double = 0.0
    @State var differentWeight : Double = 0.0
    @State private var resultMessage: String = ""
    @State private var resultColor: Color = .black

    enum Gender: String {
        case female = "female"
        case male = "male"
    }

    var body: some View {
        VStack {
            Text("Ideal Weight")
                .font(.title)
                .foregroundColor(.green)

            HStack {
                Text("Gender: ")

                Picker("", selection: $gender) {
                    Text("Female").tag(Gender.female)
                    Text("Male").tag(Gender.male)
                }
                .pickerStyle(.segmented)
            }

            HStack {
                Text("Weight: ")
                TextField("Weight in pounds.", text: $weight)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            HStack {
                Text("Height: ")
                TextField("Height in Inches", text: $height)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Button("Calculate Ideal Weight") {
                if let heightValue = Double(height) {
                    let bodyBMI: Double
                    if gender == .male {
                        bodyBMI = 22.5
                    } else {
                        bodyBMI = 21.0
                    }

                    idealWeight = (5.0 * bodyBMI) +
                                  ((bodyBMI / 5.0) * (heightValue - 60.0))
                }
                if let currentweight = Double(weight)
                {
                    let difference = currentweight - idealWeight
                    
                    switch difference
                    {
                    case let x where x > 20:
                        resultMessage = "You are overweight"
                        resultColor = .red
                    case let x where  x>=10:
                        resultMessage="You need to control your weight"
                        resultColor = .orange
                    case  5...10:
                        resultMessage = "You need to watch your weight gain."
                        resultColor = .purple
                    case -5...5:
                        resultMessage="Your are in good shape"
                        resultColor = .green
                            
                    default:
                        resultMessage="You need eat more carbohydrates"
                        resultColor = .green
                    }
                }
            }
            .buttonStyle(.bordered)
            .padding()
            
            Spacer()
            if height.isEmpty || weight.isEmpty{
                    Text("Please enter your height and weight. ")
                    .foregroundColor(.red)
        
                }
            else{
                Text("Ideal Weight: \(idealWeight, specifier: "%.2f") lbs")
                    .foregroundColor(.blue)
                Text(resultMessage)
                    .foregroundColor(resultColor)
            }
            Spacer()

        }
        .padding()
    }
}



