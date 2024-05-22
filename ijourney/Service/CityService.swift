//
//  CityService.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-22.
//

import Foundation

class CityService {
  
  private let decoder = JSONDecoder()
  private let encoder = JSONEncoder()
  
  private let networkService: NetworkService
  
  private let apiKey: String
  private let endpoint: String
  
  init(networkService: NetworkService = URLSession.shared) {
    self.networkService = networkService
    guard let endpoint = APIConfiguration.shared.geoDBEndpoint,
          let apiKey = APIConfiguration.shared.geoDBAPIKey else {
      fatalError("API not found")
    }
    self.endpoint = endpoint
    self.apiKey = apiKey
  }
  
  func fetchCoordinates(for city: City) async throws -> (Double, Double) {
    let urlString = "\(endpoint)/cities?namePrefix=\(city.name)&countryIds=\(city.countryCode)&minPopulation=\(500000)"
    let url = URL(string: urlString)!
    
    var request = URLRequest(url: url)
    request.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
    
    let data = try await networkService.fetchData(with: request)
    let geoResponse = try decoder.decode(GeoDBCitiesResponse.self, from: data)
    guard let firstCity = geoResponse.data.first else {
      throw CityError.decodingError
      // TODO: fetch again with less population
    }
    guard let latitude = firstCity.latitude, let longitude = firstCity.longitude else {
      throw CityError.missingData
    }
    return (latitude, longitude)
  }
}
