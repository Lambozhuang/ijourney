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
  
  @State private var isPresentingSheet: Bool = false
  
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
            isPresentingSheet = true
          } label: {
            Image(systemName: "plus")
          }
        }
      }
    }
    .task {
      await itineraryViewModel.generateItinerary(cityName: "Paris", countryName: "France")
    }
    .sheet(isPresented: $isPresentingSheet) {
      GICountryListView(isPresentingSheet: $isPresentingSheet)
    }
    
  }
}

#Preview {
  ItineraryList()
    .environmentObject(ItineraryViewModel(client: ItineraryClient(downloader: TestDownloader())))
    .tint(.green)
}
