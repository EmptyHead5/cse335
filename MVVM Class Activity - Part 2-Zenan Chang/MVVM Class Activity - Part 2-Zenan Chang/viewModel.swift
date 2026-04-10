//
//  viewModel.swift
//  MVVM Class Activity - Part 2-Zenan Chang
//
//  Created by zenanchang on 2/19/26.
//

import SwiftUI
import Combine
import Foundation

class viewModel: ObservableObject {
    
    @Published var location = Location()
    
    func updateLocation(city: String, state: String) {
        location.city = city
        location.state = state
    }
}
