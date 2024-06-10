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
  
  let service: ItineraryService
  let cityService: CityService
  
  init(service: ItineraryService = ItineraryService(), cityService: CityService = CityService()) {
    self.service = service
    self.cityService = cityService
  }
  
  func composeUserPrompt(city: City, startDate: Date, endDate: Date, interests: Interests) -> String {
    service.composeUserPrompt(city: city, startDate: startDate, endDate: endDate, interests: interests)
  }
  
  func generateItinerary(userPrompt: String) async throws -> Itinerary {
    try await service.fetchItinerary(userPrompt: userPrompt)
  }
  
  func getCoordinates(for city: City) async throws -> (Double, Double) {
    try await cityService.fetchCoordinates(for: city)
  }
  
  func addItinerary(itinerary: Itinerary) {
    self.itineraryList.append(itinerary)
  }
  
  func getImagesForItinerary(itinerary: Itinerary) {
    
  }
}
