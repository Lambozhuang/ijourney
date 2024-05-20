//
//  ItineraryClient.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

actor ItineraryClient {
  
//  var itinerary: Itinerary {
//    get async throws {
//      let data = try await downloader.fetchData(from: feedURL)
//      let itinerary = try decoder.decode(Itinerary.self, from: data)
//      return itinerary
//    }
//  }
  
  private let apiKey = "your-api-key-here"
  private let endpoint = "https://mock-endpoint.azurewebsites.net/openai/deployments/chat/completions"
  
  private let decoder = JSONDecoder()
  private let encoder = JSONEncoder()
  
  private let feedURL = URL(string: "233")!
  
  private let networkService: NetworkService
  
  init(networkService: NetworkService = URLSession.shared) {
    self.networkService = networkService
  }
  
  func fetchItinerary(systemPrompt: String, userPrompt: String) async throws -> Itinerary {
    let url = URL(string: endpoint)!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue(apiKey, forHTTPHeaderField: "api-key")
    
    let combinedPrompt = systemPrompt + "\n" + userPrompt
    let chatRequest = ChatGPTRequest(prompt: combinedPrompt, max_tokens: 100, temperature: 0.5)
    let requestData = try encoder.encode(chatRequest)
    request.httpBody = requestData
    
    let data = try await networkService.fetchData(with: request)
    
    if let jsonString = String(data: data, encoding: .utf8) {
      print("JSON Response: \(jsonString)")
    } else {
      print("Failed to convert data to string.")
    }
    
    let chatResponse = try decoder.decode(ChatGPTResponse.self, from: data)
    let responseText = chatResponse.choices.first?.text ?? ""
    
    guard let itineraryData = responseText.data(using: .utf8) else {
      throw ItineraryError.decodingError
    }
    
    let itinerary = try decoder.decode(Itinerary.self, from: itineraryData)
    return itinerary
  }
  
}
