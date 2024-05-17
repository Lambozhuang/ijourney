//
//  POIList.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import SwiftUI

struct POIList: View {
  var day: Day
  
  var body: some View {
    
    VStack(alignment: .leading) {
      Text("Day \(day.dayNumber)")
        .font(.body)
        .bold()
        .foregroundStyle(.secondary)
      
      LazyVStack {
        ForEach(day.pointOfInterestList) { poi in
          NavigationLink {
            POIDetail(poi: poi)
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
    .padding(.bottom)
  }
}

#Preview {
  POIList(day: Day.sampleData)
}
