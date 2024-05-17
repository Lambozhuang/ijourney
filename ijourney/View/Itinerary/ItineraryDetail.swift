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
  var itinerary: Itinerary
  var body: some View {
    
    ScrollView {
      
      ZStack(alignment: .bottomLeading) {
        
        Image(itinerary.imageName!)
          .resizable()
          .scaledToFill()
          .frame(width: UIScreen.main.bounds.width, height: 300)
          .glur(radius: 2, direction: .up)
        
        LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.75), Gradient.Stop(color: Color(UIColor.systemBackground), location: 0.95)], startPoint: .top, endPoint: .bottom)
          .frame(height: 300)
        
        HStack(alignment: .firstTextBaseline) {
          Text("Journey to \(itinerary.cityName)")
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
        
//        Text("\(itinerary.startDate.formatted(date: .abbreviated, time: .omitted)) - \(itinerary.endDate.formatted(date: .abbreviated, time: .omitted))")
//          .padding(.bottom, 30)
        
        Text("Location")
          .font(.title3)
          .bold()
        
        Map()
          .frame(height: 250)
          .clipShape(.rect(cornerRadius: 10))
          .padding(.bottom, 30)
        
        Text("Itinerary")
          .font(.title3)
          .bold()
          .padding(.bottom, 5)
        
        ForEach(itinerary.days) { day in
          POIList(day: day)
        }
        
        Spacer()
      }
      .padding()
    }
    .ignoresSafeArea()
    .navigationBarTitleDisplayMode(.inline)
    .toolbarBackground(.automatic, for: .navigationBar)
    
  }
}



#Preview {
  ItineraryDetail(itinerary: Itinerary.sampleData[0])
}
