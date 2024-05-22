//
//  ijourneyApp.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-01.
//

import SwiftUI
import SwiftData

@main
struct ijourneyApp: App {
  
  @StateObject private var itineraryViewModel = ItineraryViewModel(service: ItineraryService(networkService: TestNetworkService()))
  @StateObject private var profileViewModel = ProfileViewModel()
  @StateObject private var cityViewModel = CityViewModel()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(itineraryViewModel)
        .environmentObject(profileViewModel)
        .environmentObject(cityViewModel)
        .tint(.green)
    }
    
  }
}
