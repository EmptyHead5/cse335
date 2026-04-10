//
//  EventsViewModel.swift
//  FinalProject
//
//  Created by zenanchang on 3/21/26.
//

import Foundation
import Combine
import MapKit
import CoreLocation


struct ASUResponse: Decodable {
    let nodes: [NodeWrapper]
}

struct NodeWrapper: Decodable {
    let node: ASUEvent
}

struct ASUEvent: Decodable, Identifiable {
    let title: String
    let campus: String
    
    var id: String {
        "\(title)-\(startDate)-\(locations)"
    }
    
    let locations: String
    let startDate: String
    let imageURL: String
    let venueAddress: String
    let venueCity: String
    let venueState: String
    let venueZip: String
    
    var address: String {
        "\(venueAddress), \(venueCity), \(venueState) \(venueZip)"
    }

    enum CodingKeys: String, CodingKey {
        case title, campus, locations
        case startDate = "start_date"
        case imageURL = "image_url"
        case venueAddress = "venue_address"
        case venueCity = "venue_city"
        case venueState = "venue_state"
        case venueZip = "venue_zip"
    }
}
class EventsViewModel: ObservableObject {
    @Published var events: [ASUEvent] = []
    @Published var favoriteEventIDs: Set<String> = []
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.4, longitude: -111.9),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @Published var selectedEvent: ASUEvent?
    static let defaultLocation = CLLocationCoordinate2D(latitude: 33.4, longitude: -111.9)
    struct EventMapItem: Identifiable {
        let id = UUID()
        var name: String
        var coordinate: CLLocationCoordinate2D
    }
    
    @Published var markers: [EventMapItem] = []
    @Published var statusText: String = ""
    func analyze() {
        let urlAsString = "https://asuevents.asu.edu/feed-json/interests_lectures"
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url,completionHandler:  { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            let decoder = JSONDecoder()
            let jsonResult = try! decoder.decode(ASUResponse.self, from: data!)
            DispatchQueue.main.async {
                self.events = jsonResult.nodes.prefix(10).map { $0.node }
            }
        })
        
        jsonQuery.resume()
        print("done")
    }
    func loadCurrentEvent() {
        if let Event = selectedEvent {
            forwardGeocoding(addressStr: Event.address)
        } else {
            markers.removeAll()
            region.center = Self.defaultLocation
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
                        EventMapItem(name: placeName, coordinate: location.coordinate)
                    ]
                }

            }
        }
    }
    
    func searchNearbyPlaces(searchText: String) {

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = region

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.statusText = "Search failed: \(error.localizedDescription)"
                }
                return
            }
            if let items = response?.mapItems {

                var newMarkers: [EventMapItem] = []

                for item in items {
                    if let name = item.name {
                        let newItem = EventMapItem(
                            name: name,
                            coordinate: item.placemark.coordinate
                        )
                        newMarkers.append(newItem)
                    }
                }

                DispatchQueue.main.async {
                    self.markers = self.markers.prefix(1) + newMarkers
                    self.statusText = "Found \(newMarkers.count) place(s)."
                }

            }
        }
    }
    
    func addToFavoriteEvents(_ event: ASUEvent) {
        favoriteEventIDs.insert(event.id)
    }
    
    func removeFavoriteEvents(_ event: ASUEvent)
    {
        favoriteEventIDs.remove(event.id)
    }
    func isFavoriteEvent(_ event: ASUEvent) -> Bool
    {
        favoriteEventIDs.contains(event.id)
    }
}

