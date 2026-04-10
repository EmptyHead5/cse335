//
//  CityViewModel.swift
//  Lab 7
//
//  Created by zenanchang on 4/10/26.
//

import Foundation
import Combine
import MapKit
import CoreLocation
import UIKit
import SwiftData

class CityViewModel: ObservableObject {
    @Published var currentIndex = 0
    @Published var selectedCity: City?
    
    
    func saveCity(name: String,
                  description: String,
                  imageData: Data,
                  modelContext: ModelContext) throws {
        let city = City(name: name,
                        pictureData: imageData,
                        description: description)
        modelContext.insert(city)
        try modelContext.save()
    }
    
    func deleteCity(_ city: City, in modelContext: ModelContext) {
        modelContext.delete(city)

        do {
            try modelContext.save()
        } catch {
            print("Delete failed:", error)
        }
    }
}

