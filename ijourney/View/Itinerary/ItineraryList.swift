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
            itineraryViewModel.showGenerateItinerarySheet1 = true
          } label: {
            Image(systemName: "plus")
          }
        }
      }
    }
    .task {
      await itineraryViewModel.loadSampleData()
    }
    .sheet(isPresented: $itineraryViewModel.showGenerateItinerarySheet1) {
      GICountryListView()
    }
    
  }
}

#Preview {
  struct Preview: View {
    @StateObject var itineraryViewModel = ItineraryViewModel(service: ItineraryService(networkService: TestNetworkService()))
    var body: some View {
      ItineraryList()
        .environmentObject(ProfileViewModel())
        .environmentObject(itineraryViewModel)
        .tint(.green)
    }
  }
  return Preview()
}
