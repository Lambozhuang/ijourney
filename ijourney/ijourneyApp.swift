//
//  ijourneyApp.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-01.
//

import SwiftUI

@main
struct ijourneyApp: App {
  
  @StateObject private var itineraryViewModel = ItineraryViewModel(service: ItineraryService(networkService: TestItineraryNetworkService()))
  @StateObject private var profileViewModel = ProfileViewModel()
  @StateObject private var cityViewModel = CityViewModel()
  @StateObject private var navigationState = NavigationState()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(itineraryViewModel)
        .environmentObject(profileViewModel)
        .environmentObject(cityViewModel)
        .environmentObject(navigationState)
        .tint(.green)
    }
    
  }
}
