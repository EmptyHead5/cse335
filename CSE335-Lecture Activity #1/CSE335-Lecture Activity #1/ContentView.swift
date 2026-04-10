//
//  ContentView.swift
//  CSE335-Lecture Activity #1
//
//  Created by zenanchang on 1/17/26.
//
// New Feature:
// A reading function is added.
// The app reads the message out loud.
//
//
// The Greeting button checks whether both the first name and last name are filled in.
// If either field is empty, it prompts "Please enter both first and last name".
// If both fields are provided, it displays "<FirstName> <LastName> Welcome to CSE 335".

// The Clean button checks whether both the first name and last name fields are empty.
// If both fields are empty, it prompts "Nothing to clean, please enter first and last name".
// If at least one field contains input, the button clears all input fields and provides
// voice feedback indicating the inputs were cleared successfully.

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var Greetings: String = ""
    @State var synth: AVSpeechSynthesizer = AVSpeechSynthesizer()
    var body: some View {
        VStack(spacing:20){
            HStack{
                Text("First Name: ")
                TextField("Enter your first name here",text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Last Name: ")
                TextField("Enter your last name here", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Button("Greeting")
            {
                let texttovoice: String
                if firstName.isEmpty || lastName.isEmpty {
                    texttovoice  = "Please enter both first and last name."
                }else{
                    texttovoice = "\(firstName) \(lastName) Welcome to CSE 335"
                }
                
          
                Greetings = texttovoice
                let utterance = AVSpeechUtterance(string: texttovoice)
                if synth.isSpeaking
                {
                    synth.stopSpeaking(at: .immediate)
                }
                synth.speak(utterance)
            }
            .buttonStyle(.borderedProminent)
                .tint(.blue)
            Button("Clean")
            {

                let texttovoice: String
                if firstName.isEmpty&&lastName.isEmpty
                {
                    texttovoice="nothing to clean,please entry first name and last name"
                }
                else{
                    texttovoice="clean successfully"
                    firstName=""
                    lastName=""
                    Greetings=""
                }
                let utterance = AVSpeechUtterance(string: texttovoice)
                if synth.isSpeaking
                {
                    synth.stopSpeaking(at: .immediate)
                }
                synth.speak(utterance)
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
            
            Text(Greetings)
                .font(.largeTitle)
                
        }
        .padding()
    }
}
