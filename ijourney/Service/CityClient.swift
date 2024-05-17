//
//  CityClient.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

actor CityClient {
  
  var allCities: [City] = []
  
  private lazy var decoder: JSONDecoder = {
    let aDecoder = JSONDecoder()
    return aDecoder
  }()
  
  func getAllCities() async throws -> [City] {
    guard let url = Bundle.main.url(forResource: "country-by-cities", withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
      print("Failed to load file")
      return []
    }
    
    let jsonCountries = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
    var citiesArray: [City] = []
    for countryData in jsonCountries ?? [] {
      if let countryName = countryData["country"] as? String,
         let cityNames = countryData["cities"] as? [String] {
        let cities = cityNames.map { City(name: $0, countryName: countryName) }
        citiesArray.append(contentsOf: cities)
      }
    }
    return citiesArray
  }
  
  func getCitiesByCountry(country: Country) async {
    do {
      
    } catch {
      print("getCitiesByCountry error: \(error.localizedDescription)")
    }
  }
}
