//
//  addCityView.swift
//  Lab 7
//
//  Created by zenanchang on 4/10/26.
//

import SwiftUI
import PhotosUI
import UIKit
import SwiftData

struct addCityView: View {
    @State private var name = ""
    @State private var description = ""
    @State private var imageName = " "
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @StateObject private var viewModel = CityViewModel()
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    
    var body: some View {
        NavigationStack {
            Form {
                Section("City Info") {
                    TextField("City Name", text: $name)
                    TextField("Description", text: $description)
                }
                
                Section("Photo") {
                    if let data = selectedImageData, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    } else {
                        Image("imageCity")
                            .font(.system(size: 50))
                            .frame(maxWidth: .infinity, minHeight: 200)
                    }
                    
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Text("Select Photo")
                    }
                    .navigationTitle("Add City")
                    .toolbar {
                        Button("Save") {
                            guard !name.isEmpty, !description.isEmpty else { return }

                            let finalImageData = selectedImageData ?? UIImage(named: "imageCity")!.pngData()!

                            do {
                                try viewModel.saveCity(
                                    name: name,
                                    description: description,
                                    imageData: finalImageData,
                                    modelContext: modelContext
                                )
                                dismiss()
                            } catch {
                                print("Save failed:", error)
                            }
                        }
                    }
                    .onChange(of: selectedItem) {
                        Task {
                            selectedImageData = try? await selectedItem?.loadTransferable(type: Data.self)
                        }
                    }
                }
            }
        }
    }
}
