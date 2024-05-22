//
//  City.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

struct City: Identifiable, Codable, Equatable {
  let id = UUID()
  var name: String
  let countryCode: String
  var countryName: String
  var description: String?
  
  var latitude: Double?
  var longitude: Double?
  
  enum CodingKeys: String, CodingKey {
    case name
    case countryCode
    case countryName = "country"
    case latitude
    case longitude
  }
  
  init(name: String, countryCode: String, countryName: String, description: String? = nil, latitude: Double? = nil, longitude: Double? = nil) {
    self.name = name
    self.countryCode = countryCode
    self.countryName = countryName
    self.description = description
    self.latitude = latitude
    self.longitude = longitude
  }
}
