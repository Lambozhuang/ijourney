//
//  Profile.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

struct Profile {
  var name: String
  var birthday: Date
  
  
  static let sampleData = Profile(name: "Name", birthday: .now)
}
