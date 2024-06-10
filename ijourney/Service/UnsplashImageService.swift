//
//  UnsplashImageService.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-06-09.
//

import Foundation

class UnsplashImageService {
  
  private let decoder = JSONDecoder()
  
  private let networkService: NetworkService
  
  private let apiKey: String
  
  init(networkService: NetworkService = URLSession.shared) {
    self.networkService = networkService
    guard let key = APIConfiguration.shared.unsplashKey else {
      fatalError("API not found")
    }
    self.apiKey = key
  }
  
  func fetchImageURL(for query: String) async throws -> URL {
    guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(apiKey)") else {
      throw URLError(.badURL)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let data = try await networkService.fetchData(with: request)
    let unsplashResponse = try decoder.decode(UnsplashResponse.self, from: data)
    
    guard let firstResult = unsplashResponse.results.first else {
      throw URLError(.badServerResponse)
    }
    
    guard let imageURL = URL(string: firstResult.urls.regular) else {
      throw URLError(.badURL)
    }
    
    return imageURL
  }
}
