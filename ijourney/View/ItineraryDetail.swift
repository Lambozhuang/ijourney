//
//  ItineraryDetail.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-07.
//

import SwiftUI

struct ItineraryDetail: View {
  var itinerary: Itinerary
  var body: some View {
    Text(itinerary.cityName)
      .navigationTitle(itinerary.cityName)
      .navigationBarTitleDisplayMode(.inline)
      
  }
}

#Preview {
  ItineraryDetail(itinerary: Itinerary.sampleData[0])
}
