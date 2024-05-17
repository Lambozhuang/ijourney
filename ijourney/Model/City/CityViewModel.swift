//
//  CityViewModel.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

@MainActor
class CityViewModel: ObservableObject {
  @Published var allCities: [City] = []
  
  func loadCities() {
    guard let url = Bundle.main.url(forResource: "country-by-cities", withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
      print("Failed to load file")
      return
    }
    
    // Parse the JSON manually since the structure has changed
    do {
      let jsonCountries = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
      var citiesArray: [City] = []
      for countryData in jsonCountries ?? [] {
        if let countryName = countryData["country"] as? String,
           let cityNames = countryData["cities"] as? [String] {
          let cities = cityNames.map { City(name: $0, countryName: countryName) }
          citiesArray.append(contentsOf: cities)
        }
      }
      allCities = citiesArray
    } catch {
      print("Failed to decode JSON: \(error)")
    }
  }
}
