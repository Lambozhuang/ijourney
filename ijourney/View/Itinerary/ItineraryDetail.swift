//
//  ItineraryDetail.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-07.
//

import SwiftUI
import MapKit
import Glur

struct ItineraryDetail: View {
  var isPreview: Bool
  var itinerary: Itinerary
  var body: some View {
    
    ScrollView {
      
      ZStack(alignment: .bottomLeading) {
        
        Image(itinerary.cityName ?? "")
          .resizable()
          .scaledToFill()
          .frame(width: UIScreen.main.bounds.width, height: 300)
          .glur(radius: 2, direction: .up)
        
        LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.75), Gradient.Stop(color: Color(UIColor.systemBackground), location: 0.95)], startPoint: .top, endPoint: .bottom)
          .frame(height: 300)
        
        HStack(alignment: .firstTextBaseline) {
          Text("Journey to \(itinerary.cityName ?? "")")
            .font(.system(.title, design: .serif))
            .fontWeight(.bold)
          Text(itinerary.countryName ?? "")
            .font(.body)
            .padding(.leading, 10)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
        .offset(y: 25)
        
      }
      
      VStack(alignment: .leading) {
        
        if let startDate = itinerary.startDate, let endDate = itinerary.endDate {
          Text("\(startDate.formatted(date: .abbreviated, time: .omitted)) - \(endDate.formatted(date: .abbreviated, time: .omitted))")
            .padding(.bottom, 20)
        }
        
        Text("Location")
          .font(.title3)
          .bold()
        
        Map()
          .frame(height: 250)
          .clipShape(.rect(cornerRadius: 10))
          .padding(.bottom, 20)
        
        Text("Itinerary")
          .font(.title3)
          .bold()
          .padding(.bottom, 5)
        
        ForEach(Array(itinerary.days.enumerated()), id: \.element.id) { index, day in
          VStack(alignment: .leading) {
            Text("Day \(index + 1)")
              .font(.body)
              .bold()
              .foregroundStyle(.secondary)
            POIList(day: day)
            
          }
          .padding(.bottom)
          
        }
        
        Spacer()
      }
      .padding()
    }
    .navigationBarTitleDisplayMode(.inline)
    .toolbarBackground(.automatic, for: .navigationBar)
    .ignoresSafeArea(edges: .top)
    .toolbar {
      ToolbarItem {
        if !isPreview {
          Menu {
            Button("Delete Itinerary", role: .destructive) {
              
            }
          } label: {
            Image(systemName: "ellipsis.circle")
          }
        }
      }
    }
  }
}



#Preview {
  ItineraryDetail(isPreview: false, itinerary: Itinerary.sampleData[0])
}
