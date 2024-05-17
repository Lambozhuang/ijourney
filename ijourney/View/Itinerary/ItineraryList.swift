//
//  ItineraryList.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-01.
//

import SwiftUI
import SwiftData

struct ItineraryList: View {
  @State var itineraries: [Itinerary]
  
  var body: some View {
    NavigationStack {
      ZStack(alignment: .bottomTrailing) {
        List {
          ForEach(itineraries) { itinerary in
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
            
          } label: {
            Image(systemName: "plus")
          }
        }
      }
    }
    
  }
}

#Preview {
  ItineraryList(itineraries: Itinerary.sampleData)
    .tint(.green)
}
