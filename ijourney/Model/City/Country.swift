//
//  Country.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

struct Country: Identifiable, Codable {
  let id = UUID()
  let name: String
  let abbreviation: String
  
  enum CodingKeys: String, CodingKey {
    case name = "country"
    case abbreviation
  }
}
