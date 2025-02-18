//
//  Itinerary.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-01.
//

import Foundation
import SwiftUI

struct Itinerary: Identifiable, Codable, Equatable {
  
  let id = UUID()
  var cityName: String? = nil
  var countryName: String? = nil
  var startDate: Date? = nil
  var endDate: Date? = nil
  var imageURL: URL? = nil
  var days: [Day] = []
  var countryCode: String?
  var latitude: Double?
  var longitude: Double?
  
  enum CodingKeys: String, CodingKey {
    case cityName = "city_name"
    case countryName = "country_name"
    case days = "itinerary_list"
  }
  
  static func == (lhs: Itinerary, rhs: Itinerary) -> Bool {
    return lhs.id == rhs.id &&
    lhs.cityName == rhs.cityName &&
    lhs.countryName == rhs.countryName &&
    lhs.startDate == rhs.startDate &&
    lhs.endDate == rhs.endDate &&
    lhs.imageURL == rhs.imageURL &&
    lhs.days.count == rhs.days.count &&
    lhs.countryCode == rhs.countryCode
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
  
}
