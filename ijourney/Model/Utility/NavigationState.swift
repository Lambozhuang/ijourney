//
//  NavigationState.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-06-06.
//

import Foundation

class NavigationState: ObservableObject {
  
  @Published var selectedTab: Tab = .city
  
  @Published var showGenerateItinerarySheet1 = false
  @Published var showGenerateItinerarySheet2 = false
  @Published var isLoadingNewItinerary = false
  
  func dismissAll() {
    showGenerateItinerarySheet1 = false
    showGenerateItinerarySheet2 = false
  }
}

enum Tab {
  case city
  case itinerary
  case profile
}
