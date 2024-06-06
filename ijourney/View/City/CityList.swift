//
//  CityList.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import SwiftUI

struct CityList: View {
  
  @EnvironmentObject var cityViewModel: CityViewModel
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(cityViewModel.featuredCities) { city in
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
  CityList()
    .environmentObject(ItineraryViewModel(service: ItineraryService(networkService: TestItineraryNetworkService())))
    .environmentObject(CityViewModel())
    .environmentObject(NavigationState())
}
