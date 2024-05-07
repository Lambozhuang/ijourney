//
//  ItineraryCard.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-07.
//

import SwiftUI

struct ItineraryCard: View {
  var itinerary: Itinerary
  
  var body: some View {
    VStack {
      Image(itinerary.imageName!)
        .resizable()
        .scaledToFill()
        .frame(height: 150)
        .clipped()
      HStack {
        VStack(alignment: .leading) {
          Text(itinerary.cityName)
            .font(.title)
            .fontWeight(.bold)
          Text("\(itinerary.startDate.formatted(date: .abbreviated, time: .omitted)) - \(itinerary.endDate.formatted(date: .abbreviated, time: .omitted))")
        }
        Spacer()
        
        Image(systemName: "chevron.right")
          .font(.title)
      }
      .padding([.leading, .trailing, .bottom])
    }
    .clipShape(.rect(cornerRadius: 20))
    .background(
      Rectangle()
        .fill(.fill)
        .clipShape(.rect(cornerRadius: 20))
        .shadow(radius: 5)
    )
    
  }
}

#Preview {
  ItineraryCard(itinerary: Itinerary.sampleData[0])
}
