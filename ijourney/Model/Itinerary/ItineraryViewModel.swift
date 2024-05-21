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
  @Published var isLoadingNewItinerary = false
  
  let service: ItineraryService
  
  init(service: ItineraryService = ItineraryService()) {
    self.service = service
  }
  
  func composeUserPrompt(city: City, startDate: Date, endDate: Date, interests: Interests) -> String {
    service.composeUserPrompt(city: city, startDate: startDate, endDate: endDate, interests: interests)
  }
  
  func generateItinerary(userPrompt: String) async {
    do {
      let newItinerary = try await service.fetchItinerary(userPrompt: userPrompt)
      if Task.isCancelled { return }
      DispatchQueue.main.async {
        self.itineraryList.append(newItinerary)
      }
    } catch {
      if !Task.isCancelled {
        print("Failed to fetch itinerary: \(error)")
      }
    }
  }
  
  func addItinerary(itinerary: Itinerary) {
    self.itineraryList.append(itinerary)
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
