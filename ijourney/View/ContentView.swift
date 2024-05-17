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
      CityList()
        .tabItem { 
          Image(systemName: "building.2.fill")
          Text("City")
        }
      
      ItineraryList(itineraries: Itinerary.sampleData)
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
    .tint(.green)
}
