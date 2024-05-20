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
  
//  func generateItinerary(cityName: String, countryName: String) async {
//    do {
//      var newItinerary = try await client.itinerary
//      newItinerary.cityName = cityName
//      newItinerary.countryName = countryName
//      
//      for index in newItinerary.days.indices {
//        newItinerary.days[index].dayNumber = index + 1
//      }
//      
//      self.itineraryList.append(newItinerary)
//    } catch {
//      print(error)
//    }
//    
//  }
  
  func generateItinerary(systemPrompt: String, userPrompt: String) async {
    do {
      let newItinerary = try await client.fetchItinerary(systemPrompt: systemPrompt, userPrompt: userPrompt)
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
