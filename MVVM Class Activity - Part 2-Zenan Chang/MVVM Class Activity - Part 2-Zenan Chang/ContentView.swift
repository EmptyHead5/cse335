//
//  ContentView.swift
//  MVVM Class Activity - Part 2-Zenan Chang
//
//  Created by zenanchang on 2/19/26.
//


// The app displays "Current Location" on the Main page.

// If the user has not added any location yet,
// the "Current Location" field will remain empty.

// The user must enter a city and state,
// and press the "Add My Location" button to update the ViewModel.

// If the user does NOT press "Add My Location",
// the location will NOT be saved,
// and navigating to the Second View will still show empty information.

// When navigating to the Second View,
// the current saved location (if any) will be displayed.

// In the Second View, the user can edit the city and state.

// However, the user must press the "Edit" button
// to update the location in the ViewModel.

// If the user edits the text fields but does NOT press "Edit",
// and simply presses "Back",
// the changes will NOT be saved.

// Only after pressing "Add My Location" (in Main)
// or "Edit" (in Second)
// will the "Current Location" display reflect the updated information.

import SwiftUI

struct ContentView: View {
    @StateObject var viewModellocation = viewModel()
    @State private var city = ""
    @State private var state = ""


    var body: some View {
        NavigationView {
            VStack {
                Text("Enter your location")
                    .font(.title)
                
                HStack {
                    Text("City: ")
                    TextField("Enter your City", text: $city)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("State: ")
                    TextField("Enter your State", text: $state)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Text("Current Location")
                Text("\(viewModellocation.location.city), \(viewModellocation.location.state)")
                Button("Add My Location") {
                    viewModellocation.updateLocation(
                        city: city , state: state
                    )
                }
                NavigationLink("Go to Second View") {
                    secondContentView(viewModel2: viewModellocation)
                }
            }
        }
        
    }
}


#Preview {
    ContentView()
}
