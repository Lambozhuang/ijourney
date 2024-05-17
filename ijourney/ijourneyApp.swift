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
  
  @StateObject private var itineraryViewModel = ItineraryViewModel()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(itineraryViewModel)
        .tint(.green)
    }
    
  }
}
