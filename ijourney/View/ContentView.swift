//
//  ContentView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import SwiftUI

struct ContentView: View {
  
  @EnvironmentObject var navigationState: NavigationState
  
  var body: some View {
    TabView(selection: $navigationState.selectedTab) {
      CityList(cities: City.sampleData)
        .tabItem { 
          Image(systemName: "building.2.fill")
          Text("Explore")
        }
        .tag(Tab.city)
      
      ItineraryList()
        .tabItem {
          Image(systemName: "point.bottomleft.forward.to.point.topright.filled.scurvepath")
          Text("Itinerary")
        }
        .tag(Tab.itinerary)
      
      ProfileView()
        .tabItem {
          Image(systemName: "person.fill")
          Text("Profile")
        }
        .tag(Tab.profile)
    }
  }
}

#Preview {
  ContentView()
    .environmentObject(ItineraryViewModel(service: ItineraryService(networkService: TestItineraryNetworkService())))
    .environmentObject(ProfileViewModel())
    .environmentObject(NavigationState())
    .environmentObject(CityViewModel())
    .tint(.green)
}
