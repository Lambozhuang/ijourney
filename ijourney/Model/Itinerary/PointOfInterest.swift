//
//  PointOfInterest.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

struct PointOfInterest: Identifiable, Hashable, Codable {
  let id: UUID
  var name: String
  var type: InterestType
  var description: String? = nil

  var imageURL: URL? = nil
  var latitude: Double? = nil
  var longitude: Double? = nil
  
  
  private enum CodingKeys: String, CodingKey {
    case name
    case type
    case description
  }
  
  init(name: String, imageURL: URL?, type: InterestType, latitude: Double, longitude: Double, description: String? = nil) {
    self.id = UUID()
    self.name = name
    self.imageURL = imageURL
    self.type = type
    self.latitude = latitude
    self.longitude = longitude
    self.description = description
  }
  
  init(from decoder: Decoder) throws {
    self.id = UUID()
    
    let values = try decoder.container(keyedBy: CodingKeys.self)
    let rawName = try? values.decode(String.self, forKey: .name)
    let rawType = try? values.decode(InterestType.self, forKey: .type)
    let rawDescription = try? values.decode(String.self, forKey: .description)
    
    guard let name = rawName,
          let type = rawType,
          let description = rawDescription
    else {
      throw ItineraryError.missingData
    }
    
    self.name = name
    self.type = type
    self.description = description
    
  }
  
  static let sampleData = PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0)
  
}

enum InterestType: String, Codable, CaseIterable {
  case historical = "Historical"
  case cultural = "Cultural"
  case nature = "Nature"
  case entertainment = "Entertainment"
  case shopping = "Shopping"
  case adventure = "Adventure"
  case relaxing = "Relaxing"
  case food = "Food"
  case nightlife = "Nightlife"
  
  var emoji: String {
    switch self {
    case .historical: return "🏛️"
    case .cultural: return "🎭"
    case .nature: return "🌲"
    case .entertainment: return "🎉"
    case .shopping: return "🛍️"
    case .adventure: return "🧗‍♂️"
    case .relaxing: return "🛌"
    case .food: return "🍲"
    case .nightlife: return "🌃"
    }
  }
}
