//
//  CityList.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import SwiftUI

struct CityList: View {
  
  var cities: [City]
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(cities) { city in
          ZStack {
            CityCard(city: city)
            NavigationLink {
              
              CityDetail(city: city)
            } label: {
              EmptyView()
            }
            .opacity(0)
            
            
          }
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
      }
      .navigationTitle("Explore Cities")
      .listStyle(.plain)
    }
  }
}

#Preview {
  CityList(cities: City.sampleData)
}
