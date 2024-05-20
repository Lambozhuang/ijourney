//
//  CityDetail.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import SwiftUI
import MapKit
import Glur

struct CityDetail: View {
  
  @State private var showCreateItinerary = false
  
  var city: City
  
  var body: some View {
    
    ScrollView {
      ZStack(alignment: .bottomLeading) {
        
        Image(city.name)
          .resizable()
          .scaledToFill()
          .frame(width: UIScreen.main.bounds.width, height: 300)
          .glur(radius: 2, direction: .up)
          .ignoresSafeArea()
        
        LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.75), Gradient.Stop(color: Color(UIColor.systemBackground), location: 0.95)], startPoint: .top, endPoint: .bottom)
          .frame(height: 300)
          .ignoresSafeArea()
        
        HStack(alignment: .firstTextBaseline) {
          Text(city.name)
            .font(.system(.largeTitle, design: .serif))
            .fontWeight(.bold)
          Text(city.countryName)
            .font(.body)
            .padding(.leading, 10)
          Spacer()
          Menu {
            Button("Create Itinerary") {
              showCreateItinerary = true
            }
          } label: {
            Image(systemName: "ellipsis.circle")
              .font(.title2)
          }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
        .offset(y: 25)
      }
      .padding(.bottom, 5)
      VStack(alignment: .leading) {
        
        HStack(alignment: .firstTextBaseline) {
          Text("Location")
            .font(.title3)
            .bold()
          Spacer()
          Button {
            
          } label: {
            Text("View in Maps")
          }
        }
        Map()
          .frame(height: 250)
          .clipShape(.rect(cornerRadius: 10))
          .padding(.bottom, 30)
        
        Text("Description")
          .font(.title3)
          .bold()
          .padding(.bottom, 5)
        Text(city.description ?? "")
        Spacer()
      }
      .padding()
    }
    .navigationBarTitleDisplayMode(.inline)
    .toolbarBackground(.automatic, for: .navigationBar)
    .ignoresSafeArea(edges: .top)
    .fullScreenCover(isPresented: $showCreateItinerary) {
      GenerateItineraryView(city: city)
    }
  }
}

#Preview {
  CityDetail(city: City.sampleData[0])
}
