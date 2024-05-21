//
//  SampleData.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-21.
//

import Foundation

extension City {
  static let sampleData = [
    City(name: "Rome", countryName: "Italy", description: "Rome (Italian and Latin: Roma, Italian: [ˈroːma] ⓘ) is the capital city of Italy. It is also the capital of the Lazio region, the centre of the Metropolitan City of Rome Capital, and a special comune (municipality) named Comune di Roma Capitale. With 2,860,009 residents in 1,285 km2 (496.1 sq mi),[2] Rome is the country's most populated comune and the third most populous city in the European Union by population within city limits. The Metropolitan City of Rome, with a population of 4,355,725 residents, is the most populous metropolitan city in Italy.[3] Its metropolitan area is the third-most populous within Italy.[5] Rome is located in the central-western portion of the Italian Peninsula, within Lazio (Latium), along the shores of the Tiber. Vatican City (the smallest country in the world)[6] is an independent country inside the city boundaries of Rome, the only existing example of a country within a city. Rome is often referred to as the City of Seven Hills due to its geographic location, and also as the \"Eternal City\". Rome is generally considered to be the cradle of Western civilization and Western Christian culture, and the centre of the Catholic Church."),
    City(name: "Paris", countryName: "France", description: "Paris[a] is the capital and most populous city of France. With an official estimated population of 2,102,650 residents as of 1 January 2023[2] in an area of more than 105 km2 (41 sq mi),[5] Paris is the fourth-most populated city in the European Union and the 30th most densely populated city in the world in 2022.[6] Since the 17th century, Paris has been one of the world's major centres of finance, diplomacy, commerce, culture, fashion, and gastronomy. For its leading role in the arts and sciences, as well as its early and extensive system of street lighting, in the 19th century, it became known as the City of Light.")
  ]
}

extension Itinerary {
  static let sampleData: [Itinerary] = [
    Itinerary(cityName: "Rome", countryName: "Italy", days: [
      Day(dayNumber: 1, pointOfInterestList: [
        PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
        PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
      ]),
      Day(dayNumber: 2, pointOfInterestList: [
        PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
        PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
      ])
    ]),
    Itinerary(cityName: "Athens", countryName: "Greece", days: [
      Day(dayNumber: 1, pointOfInterestList: [
        PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
        PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
      ])
    ])
  ]
}

extension Day {
  static let sampleData = Day(dayNumber: 1, pointOfInterestList: [
    PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
    PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
  ])
}

extension PointOfInterest {
  static let sampleData = PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0)
}

extension ItineraryViewModel {
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
