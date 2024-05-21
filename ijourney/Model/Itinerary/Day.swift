//
//  Day.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

struct Day: Identifiable, Codable {
  let id: UUID
  var dayNumber: Int? = nil
  var pointOfInterestList: [PointOfInterest]
  
  enum CodingKeys: String, CodingKey {
    case pointOfInterestList = "poi_list"
  }
  
  init(dayNumber: Int, pointOfInterestList: [PointOfInterest]) {
    self.id = UUID()
    self.dayNumber = dayNumber
    self.pointOfInterestList = pointOfInterestList
  }
  
  init(from decoder: any Decoder) throws {
    self.id = UUID()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.pointOfInterestList = try container.decode([PointOfInterest].self, forKey: .pointOfInterestList)
  }
}
