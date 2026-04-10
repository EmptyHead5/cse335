//
//  AddParkView.swift
//  Lab 5
//
//  Created by zenanchang on 3/20/26.
//

import SwiftUI

struct AddParkView: View {
    @ObservedObject var viewModel: ParkViewModel
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var location = ""
    @State private var description = ""
    @State private var imageName = " "
    var body: some View {
        NavigationStack {
            Form {
                TextField("Park Name", text: $name)
                TextField("Location", text: $location)
                TextField("Image Name", text: $imageName)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add Park")
            .toolbar {
                Button("Save") {
                    if name.isEmpty || location.isEmpty {
                        return
                    }

                    let trimmedImage = imageName.trimmingCharacters(in: .whitespacesAndNewlines)
                    var finalImageName: String

                    if trimmedImage.isEmpty {
                        finalImageName = "defaultPark"
                    } else {
                        finalImageName = trimmedImage
                    }

                    let newPark = Park(
                        name: name,
                        location: location,
                        imageName: finalImageName,
                        description: description
                    )

                    viewModel.addPark(park: newPark)
                    dismiss()
                }
            }
        }
    }
}
