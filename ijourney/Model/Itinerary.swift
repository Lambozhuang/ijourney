//
//  Itinerary.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-01.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Itinerary {
  
  var cityName: String
  var countryName: String
  var startDate: Date
  var endDate: Date
  var imageName: String?
  
  init(cityName: String, countryName: String, startDate: Date = .now, endDate: Date = .init(timeIntervalSinceNow: 86_400), imageName: String? = nil) {
    self.cityName = cityName
    self.countryName = countryName
    self.startDate = startDate
    self.endDate = endDate
    
    if let imageName {
      self.imageName = imageName
    }
  }
  
  static let sampleData: [Itinerary] = [
    Itinerary(cityName: "Rome", countryName: "Italy", imageName: "rome-italy"),
    Itinerary(cityName: "Athens", countryName: "Greece", imageName: "athens-greece")
  ]
  
}
