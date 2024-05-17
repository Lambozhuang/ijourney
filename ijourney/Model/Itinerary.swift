//
//  Itinerary.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-01.
//

import Foundation
import SwiftUI

struct Itinerary: Identifiable, Codable {
  
  let id: UUID
  var cityName: String? = nil
  var countryName: String? = nil
  var startDate: Date? = nil
  var endDate: Date? = nil
  var imageName: String? = nil
  var imageURL: URL? = nil
  var days: [Day]
  
  enum CodingKeys: String, CodingKey {
    case days = "itinerary_list"
  }
  
  init(cityName: String, countryName: String, startDate: Date = .now, endDate: Date = .init(timeIntervalSinceNow: 86_400), imageName: String? = nil, imageURL: URL? = nil, days: [Day]) {
    self.id = UUID()
    self.cityName = cityName
    self.countryName = countryName
    self.startDate = startDate
    self.endDate = endDate
    if let imageName {
      self.imageName = imageName
    }
    self.days = days
  }
  
  init(from decoder: any Decoder) throws {
    self.id = UUID()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.days = try container.decode([Day].self, forKey: .days)
  }
  
  static let sampleData: [Itinerary] = [
    Itinerary(cityName: "Rome", countryName: "Italy", imageName: "rome-italy", days: [
      Day(dayNumber: 1, pointOfInterestList: [
        PointOfInterest(name: "Colosseum", imageName: "rome-italy", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
        PointOfInterest(name: "Colosseum", imageName: "rome-italy", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
      ]),
      Day(dayNumber: 2, pointOfInterestList: [
        PointOfInterest(name: "Colosseum", imageName: "rome-italy", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
        PointOfInterest(name: "Colosseum", imageName: "rome-italy", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
      ])
    ]),
    Itinerary(cityName: "Athens", countryName: "Greece", imageName: "athens-greece", days: [
      Day(dayNumber: 1, pointOfInterestList: [
        PointOfInterest(name: "Colosseum", imageName: "rome-italy", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
        PointOfInterest(name: "Colosseum", imageName: "rome-italy", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
      ])
    ])
  ]
  
}
