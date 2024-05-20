//
//  Profile.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

struct Profile: Equatable {
  var name: String
  var birthday: Date
  
  var primaryLanguage: MajorLanguage = .english
  var secondaryLangauge: MajorLanguage = .none
  
  static let sampleData = Profile(name: "John", birthday: .now)
  
  static func ==(lhs: Profile, rhs: Profile) -> Bool {
    return lhs.name == rhs.name &&
    lhs.birthday == rhs.birthday &&
    lhs.primaryLanguage == rhs.primaryLanguage &&
    lhs.secondaryLangauge == rhs.secondaryLangauge
  }
  
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
  case none // This represents no selection
  
  var id: String { self.rawValue }
  
  var displayName: String {
    switch self {
    case .none:
      return "None"
    default:
      let locale = NSLocale(localeIdentifier: self.rawValue)
      return locale.displayName(forKey: .identifier, value: self.rawValue) ?? self.rawValue
    }
  }
}
