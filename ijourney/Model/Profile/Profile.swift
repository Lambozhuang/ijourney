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
  
  var interests: Interests = Interests()
  
  static let sampleData = Profile(name: "John", birthday: .now)
  
  static func ==(lhs: Profile, rhs: Profile) -> Bool {
    return lhs.name == rhs.name &&
    lhs.birthday == rhs.birthday &&
    lhs.primaryLanguage == rhs.primaryLanguage &&
    lhs.secondaryLangauge == rhs.secondaryLangauge &&
    lhs.interests == rhs.interests
  }
  
}

struct Interests: Equatable {
  private var interestMap: [InterestType: InterestLevel] = [:]
  
  subscript(interestType: InterestType) -> InterestLevel? {
    get {
      return interestMap[interestType]
    }
    set {
      interestMap[interestType] = newValue
    }
  }
}

enum InterestLevel: String, CaseIterable {
  case veryLow = "Very Low"
  case low = "Low"
  case medium = "Medium"
  case high = "High"
  case veryHigh = "Very High"
  
  var value: Double {
    switch self {
    case .veryLow: return 0
    case .low: return 1
    case .medium: return 2
    case .high: return 3
    case .veryHigh: return 4
    }
  }
  
  init(value: Double) {
    switch value {
    case 0: self = .veryLow
    case 1: self = .low
    case 2: self = .medium
    case 3: self = .high
    case 4: self = .veryHigh
    default: self = .medium
    }
  }
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
      let locale = Locale(identifier: self.rawValue)
      return locale.localizedString(forIdentifier: self.rawValue) ?? self.rawValue
    }
  }
}
