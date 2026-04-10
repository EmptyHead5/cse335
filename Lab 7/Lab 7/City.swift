//
//  City.swift
//  Lab 7
//
//  Created by zenanchang on 4/10/26.
//

import Foundation
import SwiftData

@Model
final class City {
    var id: UUID
    var name: String
    var pictureData: Data
    var cityDescription: String

    init(name: String, pictureData: Data, description: String) {
        self.id = UUID()
        self.name = name
        self.pictureData = pictureData
        self.cityDescription = description
    }
}
