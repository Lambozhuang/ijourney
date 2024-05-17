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
      Image(itinerary.imageName!)
        .resizable()
        .scaledToFill()
        .clipped()
        .frame(width: (UIScreen.main.bounds.width - 40), height: 250)
        .glur(radius: 2)
      
      HStack {
        VStack(alignment: .leading) {
          Text("Journey to \(itinerary.cityName)")
            .font(.system(.title, design: .serif))
            .fontWeight(.bold)
//          Text("\(itinerary.startDate.formatted(date: .abbreviated, time: .omitted)) - \(itinerary.endDate.formatted(date: .abbreviated, time: .omitted))")
        }
        .foregroundStyle(.white)
        
        Spacer()
        
        Image(systemName: "chevron.right")
          .font(.title)
      }
      .shadow(radius: 2)
      .padding([.leading, .trailing, .bottom])
      
    }
    .frame(width: (UIScreen.main.bounds.width - 40), height: 250)
    .clipShape(.rect(cornerRadius: 20))
    
  }
}

#Preview {
  ItineraryCard(itinerary: Itinerary.sampleData[0])
}
