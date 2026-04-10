//
//  GeoNamesResponse.swift .swift
//  Lab 6
//
//  Created by zenanchang on 3/27/26.
//

import Foundation
import Combine

struct GeoNamesResponse: Codable {
    let geonames: [City]
}

struct City: Codable, Identifiable {
    let lng: Double
    let geonameId: Int
    let countrycode: String
    let name: String
    let lat: Double
    let population: Int

    var id: Int { geonameId }
}

class GeonamesAPI: ObservableObject {
    @Published var cities: [City] = []

    func analyze() {
        let urlAsString = "http://api.geonames.org/citiesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&username=zchang8"
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared

        let jsonQuery = urlSession.dataTask(with: url,completionHandler:  { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            let decoder = JSONDecoder()
            let jsonResult = try! decoder.decode(GeoNamesResponse.self, from: data!)
            DispatchQueue.main.async {
                self.cities = Array(jsonResult.geonames.prefix(10))
            }
        })

        jsonQuery.resume()
        print("done")
    }
}
