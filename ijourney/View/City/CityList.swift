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
      ZStack(alignment: .bottomTrailing) {
        List {
          ForEach(cities) { city in
            ZStack(alignment: .topTrailing) {
              CityCard(city: city)
              NavigationLink {
                
                CityDetail(city: city)
              } label: {
                EmptyView()
              }
              .opacity(0)
              
              Menu {
                Button("Option 1", action: {print("1") })
                Button("Option 2", action: {print("2") })
              } label: {
                Image(systemName: "ellipsis.circle")
                  .font(.title2)
                  .padding()
              }
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
}

#Preview {
  CityList(cities: City.sampleData)
}
