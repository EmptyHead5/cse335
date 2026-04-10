//
//  CityDetailView.swift
//  Lab 7
//
//  Created by zenanchang on 4/10/26.
//

import SwiftUI
import UIKit
struct CityDetailView: View {
    let city: City
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        ScrollView
        {
            Text(city.name)
                .font(.title)
            if let uiImage = UIImage(data: city.pictureData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(8)
            }
            Text(city.cityDescription)
        }
    }
}

#Preview
{
    ContentView()
}
