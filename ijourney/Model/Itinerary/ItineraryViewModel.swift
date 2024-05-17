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
  
  let client: ItineraryClient
  
  init(client: ItineraryClient = ItineraryClient()) {
    self.client = client
  }
  
  func generateItinerary(cityName: String, countryName: String) async {
    do {
      var newItinerary = try await client.itinerary
      newItinerary.cityName = cityName
      newItinerary.countryName = countryName
      
      for index in newItinerary.days.indices {
        newItinerary.days[index].dayNumber = index + 1
      }
      
      self.itineraryList.append(newItinerary)
    } catch {
      print(error)
    }
    
  }
  
}
