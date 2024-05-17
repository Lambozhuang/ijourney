//
//  ContentView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import SwiftUI

struct ContentView: View {
  
  @EnvironmentObject var itineraryViewModel: ItineraryViewModel
  
  var body: some View {
    TabView {
      CityList(cities: City.sampleData)
        .tabItem { 
          Image(systemName: "building.2.fill")
          Text("City")
        }
      
      ItineraryList()
        .environmentObject(itineraryViewModel)
        .tabItem {
          Image(systemName: "point.bottomleft.forward.to.point.topright.filled.scurvepath")
          Text("Itinerary")
        }
      
      ProfileView(profile: Profile.sampleData)
        .tabItem {
          Image(systemName: "person.fill")
          Text("Profile")
        }
    }
  }
}

#Preview {
  ContentView()
    .environmentObject(ItineraryViewModel(client: ItineraryClient(downloader: TestDownloader())))
    .tint(.green)
}
