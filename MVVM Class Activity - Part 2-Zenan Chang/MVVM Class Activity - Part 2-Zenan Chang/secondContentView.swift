//
//  secondContentView.swift
//  MVVM Class Activity - Part 2-Zenan Chang
//
//  Created by zenanchang on 2/19/26.
//


import SwiftUI


struct secondContentView: View{
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel2 : viewModel
    
    @State var city = ""
    @State var state = ""
    
    init( viewModel2: viewModel) {
        self.viewModel2 = viewModel2
        _city=State(initialValue: viewModel2.location.city)
        _state=State(initialValue: viewModel2.location.state)
    }
        var body : some View
    {
        
        VStack(){
            Text("Edit Location")
                .font(.title)
            TextField("Enter your city", text: $city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            TextField("Enter your state", text: $state)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            Button("Edit")
            {
                viewModel2.updateLocation(city: city, state: state)
            }
            Button("Back")
            {
                dismiss()
            }
        }
        .padding()
    }
}



