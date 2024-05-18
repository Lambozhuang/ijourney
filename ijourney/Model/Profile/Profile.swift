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
  
  var primaryLanguage: MajorLanguage? = .english
  var secondaryLangauge: MajorLanguage?
  
  static let sampleData = Profile(name: "John", birthday: .now)
  
}

enum InterestLevel: String, CaseIterable {
  case veryLow = "Very Low"
  case low = "Low"
  case medium = "Medium"
  case high = "High"
  case veryHigh = "Very High"
}

enum MajorLanguage: String, CaseIterable, Identifiable {
  case english = "en"
  case spanish = "es"
  case french = "fr"
  case german = "de"
  case chinese = "zh"
  case japanese = "ja"
  case russian = "ru"
  case arabic = "ar"
  case portuguese = "pt"
  case hindi = "hi"
  
  var id: String { self.rawValue }
  
  var displayName: String {
    let locale = NSLocale(localeIdentifier: self.rawValue)
    return locale.displayName(forKey: .identifier, value: self.rawValue) ?? self.rawValue
  }
}
