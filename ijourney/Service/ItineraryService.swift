//
//  ItineraryService.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

class ItineraryService {

  private let decoder = JSONDecoder()
  private let encoder = JSONEncoder()
  
  private let networkService: NetworkService
  
  private let endpoint = APIConfiguration.shared.endpoint
  private let apiKey = APIConfiguration.shared.apiKey
  private let systemPrompt = APIConfiguration.shared.systemPrompt
  
  private let timeoutInterval: TimeInterval = 120.0
  
  init(networkService: NetworkService = URLSession.shared) {
    self.networkService = networkService
  }
  
  func composeUserPrompt(city: City, startDate: Date, endDate: Date, interests: Interests) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let itineraryLength = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day! + 1
    
    var interestDescriptions = [String]()
    for interest in InterestType.allCases {
      if let level = interests[interest], level != .veryLow {
        interestDescriptions.append("\(interest.rawValue): \(level.rawValue)")
      }
    }
    
    let interestString = interestDescriptions.joined(separator: ",\n        ")
    
    return """
    Trip Plan: {
        Target Country: \(city.countryName),
        Target City: \(city.name),
        Itinerary Length: \(itineraryLength) Days,
        Personal Interests: {
            \(interestString)
        }
    }
    """
  }
  
  func fetchItinerary(userPrompt: String) async throws -> Itinerary {
    
    let url = URL(string: endpoint)!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue(apiKey, forHTTPHeaderField: "api-key")
    request.timeoutInterval = timeoutInterval
    
    let messages = [
      ChatMessage(role: "system", content: systemPrompt),
      ChatMessage(role: "user", content: userPrompt)
    ]
    let chatRequest = ChatRequest(messages: messages)
    let requestData = try encoder.encode(chatRequest)
    request.httpBody = requestData
    
    if Task.isCancelled { throw ItineraryError.networkError }
    let data = try await networkService.fetchData(with: request)
    
    if Task.isCancelled { throw ItineraryError.networkError }
    let chatResponse = try decoder.decode(ChatResponse.self, from: data)
    let responseText = chatResponse.choices.first?.message.content ?? ""
    
    guard let itineraryData = responseText.data(using: .utf8) else {
      throw ItineraryError.decodingError
    }
    
    let itinerary = try decoder.decode(Itinerary.self, from: itineraryData)
    return itinerary
  }
  
}
