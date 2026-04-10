//
//  viewmodel.swift
//  Lab 6
//
//  Created by zenanchang on 3/27/26.
//

import Foundation
import Combine
import MapKit
import CoreLocation


class ViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.4, longitude: -111.9),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @Published var selectedCity: City?
    struct CityItem: Identifiable {
        let id = UUID()
        var name: String
        var coordinate: CLLocationCoordinate2D
    }
    @Published var markers: [CityItem] = []
    
    func loadCurrentLocation()
    {
        if let location = selectedCity
        {
            forwardGeocoding(addressStr: location.name)
        }
    }
    
    func forwardGeocoding(addressStr: String) {
        let geocoder = CLGeocoder()

        geocoder.geocodeAddressString(addressStr) { placemarks, error in
            if error != nil {
                print("Geocode failed: \(error!.localizedDescription)")
            }
            
            if let location = placemarks?.first?.location {
                var placeName = addressStr
                if let locality = placemarks?.first?.locality {
                    placeName = locality
                } else if let name = placemarks?.first?.name {
                    placeName = name
                }

                DispatchQueue.main.async {
                    self.region.center = location.coordinate
                    self.markers = [
                        CityItem(name: placeName, coordinate: location.coordinate)
                    ]
                }

            }
        }
    }
    
}

