//
//  ItineraryList.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-01.
//

import SwiftUI
import SwiftData

struct ItineraryList: View {
  
  @EnvironmentObject var itineraryViewModel: ItineraryViewModel
  @EnvironmentObject var profileViewModel: ProfileViewModel
  @EnvironmentObject var navigationState: NavigationState
  
  var body: some View {
    NavigationStack {
      ZStack(alignment: .bottomTrailing) {
        List {
          ForEach(itineraryViewModel.itineraryList) { itinerary in
            ZStack {

              ItineraryCard(itinerary: itinerary)
              
              NavigationLink {
                ItineraryDetail(isPreview: false, itinerary: itinerary)
              } label: {
                EmptyView()
              }
              .opacity(0)
            }
          }
          .listRowBackground(Color.clear)
          .listRowSeparator(.hidden)
        }
        .navigationTitle("My Itinerary")
        .listStyle(.plain)
        
      }
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            navigationState.showGenerateItinerarySheet1 = true
          } label: {
            Image(systemName: "plus")
          }
        }
      }
    }
    .sheet(isPresented: $navigationState.showGenerateItinerarySheet1) {
      GICountryListView()
    }
    
  }
}

#Preview {
  struct Preview: View {
    @StateObject var itineraryViewModel = ItineraryViewModel(service: ItineraryService(networkService: TestItineraryNetworkService()))
    var body: some View {
      ItineraryList()
        .environmentObject(ProfileViewModel())
        .environmentObject(itineraryViewModel)
        .environmentObject(NavigationState())
        .tint(.green)
    }
  }
  return Preview()
}
