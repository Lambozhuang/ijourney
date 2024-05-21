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
}
