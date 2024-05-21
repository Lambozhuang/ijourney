//
//  City.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

struct City: Identifiable, Codable, Equatable {
  let id: UUID
  var name: String
  let countryCode: String
  var countryName: String
  var description: String?
  
  var latitude: Double?
  var longitude: Double?
  
  init(name: String, countryCode: String, countryName: String, description: String? = nil) {
    self.id = UUID()
    self.name = name
    self.countryCode = countryCode
    self.countryName = countryName
    self.description = description
  }
}
