//
//  POIList.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import SwiftUI

struct POIList: View {
  var day: Day
  
  let itinerary: Itinerary
  
  var body: some View {
    
    LazyVStack {
      ForEach(day.pointOfInterestList) { poi in
        NavigationLink {
          POIDetail(poi: poi, itinerary: itinerary)
        } label: {
          POICard(poi: poi)
        }
        .padding([.leading, .trailing])
        .tint(.primary)
        
        if poi != day.pointOfInterestList.last {
          Divider()
            .padding(.top, 5)
            .padding(.leading)
        }
      }
    }
    .padding([.top, .bottom])
    .clipShape(.rect(cornerRadius: 10))
    .background(
      Rectangle()
        .fill(.fill)
        .clipShape(.rect(cornerRadius: 10))
    )
  }
}

#Preview {
  POIList(day: Day.sampleData, itinerary: Itinerary.sampleData[0])
}
