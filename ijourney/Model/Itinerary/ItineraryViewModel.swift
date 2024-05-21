//
//  ItineraryViewModel.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

@MainActor
class ItineraryViewModel: ObservableObject {
  
  @Published var itineraryList: [Itinerary] = []
  
  @Published var showGenerateItinerarySheet1 = false
  @Published var showGenerateItinerarySheet2 = false
  
  let client: ItineraryClient
  
  init(client: ItineraryClient = ItineraryClient()) {
    self.client = client
  }
  
  func composeUserPrompt(city: City, startDate: Date, endDate: Date, interests: Interests) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let start = dateFormatter.string(from: startDate)
    let end = dateFormatter.string(from: endDate)
    
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
  
  func generateItinerary(userPrompt: String) async {
    do {
      let newItinerary = try await client.fetchItinerary(userPrompt: userPrompt)
      DispatchQueue.main.async {
        self.itineraryList.append(newItinerary)
      }
    } catch {
      print("Failed to fetch itinerary: \(error)")
    }
  }
  
  func loadItinerary(from url: URL) throws -> Itinerary {
    do {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      let decoded = try decoder.decode(Itinerary.self, from: data)
      return decoded
    } catch {
      throw ItineraryViewModelError.loadItineraryError
    }
  }
  
  func loadSampleData() async {
    
    var itineraries: [Itinerary] = []
    
    // Paris
    guard let url = Bundle.main.url(forResource: "example-itinerary-1", withExtension: "json") else {
      return
    }
    
    do {
      var itinerary = try loadItinerary(from: url)
      var dateComponents = DateComponents()
      dateComponents.day = 3
      let calendar = Calendar.current
      itinerary.startDate = .now
      itinerary.endDate = calendar.date(byAdding: dateComponents, to: itinerary.startDate!)
      itineraries.append(itinerary)
    } catch {
      print(error.localizedDescription)
    }
    
    // Rome
    guard let url = Bundle.main.url(forResource: "example-itinerary-2", withExtension: "json") else {
      return
    }
    do {
      var itinerary = try loadItinerary(from: url)
      var dateComponents = DateComponents()
      dateComponents.day = 3
      let calendar = Calendar.current
      itinerary.startDate = .now
      itinerary.endDate = calendar.date(byAdding: dateComponents, to: itinerary.startDate!)
      itineraries.append(itinerary)
    } catch {
      print(error.localizedDescription)
    }
    
    itineraryList = itineraries
  }
  
  enum ItineraryViewModelError: Error {
    case loadItineraryError
  }
}
