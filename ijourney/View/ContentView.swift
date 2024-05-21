//
//  ContentView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import SwiftUI

struct ContentView: View {
  
  var body: some View {
    TabView {
      CityList(cities: City.sampleData)
        .tabItem { 
          Image(systemName: "building.2.fill")
          Text("Explore")
        }
      
      ItineraryList()
        .tabItem {
          Image(systemName: "point.bottomleft.forward.to.point.topright.filled.scurvepath")
          Text("Itinerary")
        }
      
      ProfileView()
        .tabItem {
          Image(systemName: "person.fill")
          Text("Profile")
        }
    }
  }
}

#Preview {
  ContentView()
    .environmentObject(ItineraryViewModel(service: ItineraryService(networkService: TestNetworkService())))
    .tint(.green)
}
