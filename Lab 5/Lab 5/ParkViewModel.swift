import Foundation
import Combine
import MapKit
import CoreLocation

class ParkViewModel: ObservableObject {
    @Published var currentIndex = 0
    @Published var selectedPark: Park?

    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.4, longitude: -111.9),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    struct ParkMapItem: Identifiable {
        let id = UUID()
        var name: String
        var coordinate: CLLocationCoordinate2D
    }

    @Published var markers: [ParkMapItem] = []
    @Published var statusText: String = ""

    static let defaultLocation = CLLocationCoordinate2D(latitude: 33.4, longitude: -111.9)

    @Published var parks: [Park] = [
        Park(
            name: "Zion National Park",
            location: "Utah, USA",
            imageName: "zion",
            description: "Famous for steep red cliffs and scenic canyon views."
        ),
        Park(
            name: "Yellowstone National Park",
            location: "Wyoming, USA",
            imageName: "defaultPark",
            description: "Known for geysers like Old Faithful and wildlife."
        ),
        Park(
            name: "Yosemite National Park",
            location: "California, USA",
            imageName: "yosemite",
            description: "Famous for waterfalls, granite cliffs, and giant sequoias."
        ),
        Park(
            name: "Grand Canyon National Park",
            location: "Arizona, USA",
            imageName: "grandcanyon",
            description: "Iconic canyon carved by the Colorado River."
        ),
        Park(
            name: "Banff National Park",
            location: "Alberta, Canada",
            imageName: "banff",
            description: "Beautiful turquoise lakes and mountain scenery."
        )
    ]

    func addPark(parks: Park) {
        parks.append(park)
        parks.sort { $0.name < $1.name }
    }

    

    func loadCurrentPark() {
        if let park = selectedPark {
            forwardGeocoding(addressStr: park.name)
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
                        ParkMapItem(name: placeName, coordinate: location.coordinate)
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

                var newMarkers: [ParkMapItem] = []

                for item in items {
                    if let name = item.name {
                        let newItem = ParkMapItem(
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

    func deletePark(_ park: Park) {
        parks.removeAll { $0.id == park.id }
        if currentIndex >= parks.count {
            currentIndex = parks.count - 1
        }

        loadCurrentPark()
    }
}

