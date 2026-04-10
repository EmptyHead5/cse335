//
//  MapView.swift
//  Lab 6
//
//  Created by zenanchang on 3/27/26.
//

import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var viewModel = ViewModel()
    let city: City
    var body: some View {
        VStack {
            Map(coordinateRegion: $viewModel.region,
                annotationItems: viewModel.markers) { item in
                MapAnnotation(coordinate: item.coordinate) {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                        Text(item.name)
                            .font(.caption)
                    }
                }
            }
            .frame(height: 300)
        }
        .onAppear
        {
            viewModel.selectedCity = city
            viewModel.loadCurrentLocation()
        }
    }
}

#Preview {
    ContentView()
}

