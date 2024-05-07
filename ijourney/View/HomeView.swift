//
//  HomeView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-01.
//

import SwiftUI
import SwiftData
import NavigationBarLargeTitleItems

struct HomeView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var itineraries: [Itinerary]
  
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
        .navigationTitle("My Journey")
        .navigationBarLargeTitleItems(trailing: ProfileIcon())
        .listStyle(.plain)
        
        Button {
          
        } label: {
          Image(systemName: "plus")
            .font(.title.weight(.semibold))
            .padding(10)
            .background(.tint)
            .foregroundColor(.white)
            .clipShape(Circle())
            .shadow(radius: 3)
        }
        .padding()
      }
    }
  }
}

struct ProfileIcon: View {
  var body: some View{
    Button(action: {
      print("Profile button was tapped")
    }) {
      Image(systemName: "person.circle")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .font(.title)
    }
    .padding([.trailing], 20)
  }
}

#Preview {
  HomeView()
    .modelContainer(ItinerarySampleData.shared.modelContainer)
}
