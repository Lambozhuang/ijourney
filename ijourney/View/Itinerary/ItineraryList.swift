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
  
  @State private var isPresentingCoountryList: Bool = false
  
  var body: some View {
    NavigationStack {
      ZStack(alignment: .bottomTrailing) {
        List {
          ForEach(itineraryViewModel.itineraryList) { itinerary in
            ZStack {

              ItineraryCard(itinerary: itinerary)
              
              NavigationLink {
                ItineraryDetail(itinerary: itinerary)
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
            isPresentingCoountryList = true
          } label: {
            Image(systemName: "plus")
          }
        }
      }
    }
    .task {
      await itineraryViewModel.loadSampleData()
    }
    .sheet(isPresented: $isPresentingCoountryList) {
      GICountryListView(isPresentingSheet: $isPresentingCoountryList)
    }
    
  }
}

#Preview {
  ItineraryList()
    .environmentObject(ItineraryViewModel(client: ItineraryClient(networkService: TestNetworkService())))
    .tint(.green)
}
