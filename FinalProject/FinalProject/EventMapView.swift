//
//  EventMapView.swift
//  FinalProject
//
//  Created by zenanchang on 3/21/26.
//

import MapKit
import SwiftUI

struct EventMapView: View {
    @ObservedObject var viewModel: EventsViewModel
    let event: ASUEvent
    @State private var searchText = ""
    var body: some View {
        VStack{
            Text("Current Event location is: " + event.address)
            Map(coordinateRegion: $viewModel.region,
                annotationItems: viewModel.markers) { item in
                MapAnnotation(coordinate: item.coordinate) {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                        Text(item.name ?? "")
                            .font(.caption)

                    }
                }
                
            }
                .frame(height: 300)
                .onAppear
            {
                viewModel.selectedEvent = event
                viewModel.loadCurrentEvent()
            }

        }
        VStack {
            TextField("Search around", text: $searchText)
                .textFieldStyle(.roundedBorder)
            Button("Search") {
                viewModel.searchNearbyPlaces(searchText: searchText)
            }
            .buttonStyle(.borderedProminent)
            Text(viewModel.statusText)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .onDisappear
        {
            searchText = ""
            viewModel.statusText = ""
        }
    }
}

#Preview
{
    ContentView()
}
