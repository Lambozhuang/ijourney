//
//  Itinerary.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-01.
//

import Foundation
import SwiftUI

struct Itinerary: Identifiable, Codable {
  
  let id = UUID()
  var cityName: String? = nil
  var countryName: String? = nil
  var startDate: Date? = nil
  var endDate: Date? = nil
  var imageURL: URL? = nil
  var days: [Day] = []
  
  enum CodingKeys: String, CodingKey {
    case cityName = "city_name"
    case countryName = "country_name"
    case days = "itinerary_list"
  }
  
  init() {
    
  }
  
  init(cityName: String, countryName: String, startDate: Date = .now, endDate: Date = .init(timeIntervalSinceNow: 86_400), imageURL: URL? = nil, days: [Day]) {
    self.cityName = cityName
    self.countryName = countryName
    self.startDate = startDate
    self.endDate = endDate
    self.days = days
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.cityName = try container.decode(String.self, forKey: .cityName)
    self.countryName = try container.decode(String.self, forKey: .countryName)
    self.days = try container.decode([Day].self, forKey: .days)
  }
  
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
