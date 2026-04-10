//
//  Part2.swift
//  LAB1
//
//  Created by zenanchang on 1/27/26.
//

import SwiftUI
import Charts

struct ValueData: Identifiable {
    let id = UUID()
    var weight: Int
    var bmi: Double
}


struct Part2: View {
    @State var height : String=""
    @State private var sliderweight : Double = 150
    @State var heightSquare : Double = 0.0
    @State private var chartData: [ValueData] = []
    @State private var resultMessage: String = ""
    @State private var resultColor: Color = .black
    @State var bodyBMI : Double = 0.0
    
    
    var body: some View {
        VStack(spacing: 15) {
            
            Text("BMI Calculator")
                .font(.title)
                .foregroundColor(.green)
                .padding()
            
            Text("Height (inches)")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Please input your height", text: $height)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Text("Weight (pounds): \(sliderweight, specifier: "%.0f")")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Slider(value: $sliderweight,in: 80...250, step: 1,
                   onEditingChanged: { editing in
                if !editing {
                    print(sliderweight)
                    
                    if let heightValue = Double(height) {
                        heightSquare = heightValue * heightValue
                        bodyBMI = (sliderweight / heightSquare) * 703
                        if bodyBMI < 18.5 {
                            resultMessage = "Underweight"
                            resultColor = .blue
                        } else if bodyBMI < 25 {
                            resultMessage = "Healthy"
                            resultColor = .green
                        } else if bodyBMI < 30 {
                            resultMessage = "Overweight"
                            resultColor = .orange
                        } else {
                            resultMessage = "Obesity"
                            resultColor = .red
                        }


                        let v = ValueData(
                            weight: Int(sliderweight),
                            bmi: bodyBMI
                        )
                        chartData.append(v)
                    }
                }
            }
            )
            
            Chart{
                ForEach(chartData){ data in
                    BarMark(
                        x:.value("Weight", data.weight),
                        y:.value("bmi", data.bmi)
                    ).foregroundStyle(barColor(for: data.bmi))
                }
            }
            .frame(height: 200)
            .chartXAxisLabel("Weight (pounds)")
            .chartYAxisLabel("BMI")
            .padding()
            
            HStack(spacing: 16) {

                HStack(spacing: 4) {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 8, height: 8)
                    Text("Underweight")
                        .font(.caption)
                }

                HStack(spacing: 4) {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8, height: 8)
                    Text("Healthy")
                        .font(.caption)
                }

                HStack(spacing: 4) {
                    Circle()
                        .fill(Color.orange)
                        .frame(width: 8, height: 8)
                    Text("Overweight")
                        .font(.caption)
                }

                HStack(spacing: 4) {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 8, height: 8)
                    Text("Obesity")
                        .font(.caption)
                }
            }
            .padding()

            if height.isEmpty{
                Text("Please enter your height first.")
            }else{
                Text("BMI: \(bodyBMI, specifier: "%.1f") lbs")
                    .foregroundColor(resultColor)
                Text("Status: "+resultMessage)
                    .foregroundColor(resultColor)
            }
        
        }
            Button("clear diagram")
            {
                chartData.removeAll()
                height = ""
                resultColor = .black
                resultMessage = ""
            }
            .buttonStyle(.bordered)
        }
        

    }


func barColor(for value: Double) -> Color {
      if value < 15 {
          return .blue
      } else if value >= 1 && value < 3 {
          return .green
      } else {
          return .red
      }
  }






