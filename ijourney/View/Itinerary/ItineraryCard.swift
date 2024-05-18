//
//  ItineraryCard.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-07.
//

import SwiftUI
import Glur

struct ItineraryCard: View {
  var itinerary: Itinerary
  
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      Image(itinerary.cityName ?? "")
        .resizable()
        .scaledToFill()
        .clipped()
        .frame(width: (UIScreen.main.bounds.width - 40), height: 250)
        .glur(radius: 2)
      
      HStack {
        VStack(alignment: .leading) {
          Text("Journey to \(itinerary.cityName ?? "")")
            .font(.system(.title, design: .serif))
            .fontWeight(.bold)
          if let startDate = itinerary.startDate, let endDate = itinerary.endDate {
            Text("\(startDate.formatted(date: .abbreviated, time: .omitted)) - \(endDate.formatted(date: .abbreviated, time: .omitted))")
          }

        }
        .foregroundStyle(.white)
        
        Spacer()
        
        Image(systemName: "chevron.right")
          .font(.title)
          .foregroundStyle(.white)
      }
      .shadow(radius: 2)
      .padding([.leading, .trailing, .bottom])
      
    }
    .frame(width: (UIScreen.main.bounds.width - 40), height: 250)
    .clipShape(.rect(cornerRadius: 10))
    
  }
}

#Preview {
  ItineraryCard(itinerary: Itinerary.sampleData[0])
}
