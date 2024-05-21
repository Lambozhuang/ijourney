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
  var countryName: String
  var description: String?
  
  init(name: String, countryName: String, description: String? = nil) {
    self.id = UUID()
    self.name = name
    self.countryName = countryName
    self.description = description
  }
}
