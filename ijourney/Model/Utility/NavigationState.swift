//
//  NavigationState.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-06-06.
//

import Foundation

class NavigationState: ObservableObject {
  
  @Published var isFirstLaunch: Bool
  
  @Published var selectedTab: Tab = .city
  
  @Published var showGenerateItinerarySheet1 = false
  @Published var showGenerateItinerarySheet2 = false
  @Published var isLoadingNewItinerary = false
  
  func dismissAll() {
    showGenerateItinerarySheet1 = false
    showGenerateItinerarySheet2 = false
  }
  
  init() {
    let userDefaults = UserDefaults.standard
    if userDefaults.bool(forKey: "hasLaunchedBefore") {
      self.isFirstLaunch = false
    } else {
      self.isFirstLaunch = true
    }
  }
  
  func setHasLaunchedBefore() {
    let userDefaults = UserDefaults.standard
    userDefaults.set(true, forKey: "hasLaunchedBefore")
  }
}

enum Tab {
  case city
  case itinerary
  case profile
}
