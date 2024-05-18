//
//  POICard.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import SwiftUI

struct POICard: View {
  var poi: PointOfInterest
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        VStack(alignment: .leading) {
          Text(poi.name)
            .font(.title2)
            .bold()
          Text(poi.type.rawValue)
            .foregroundStyle(.secondary)
          
        }
        Spacer()
        Image(systemName: "chevron.right")
          .font(.caption)
      }
      .frame(height: 50)
      
      Image(poi.name)
        .resizable()
        .scaledToFill()
        .frame(height: 150)
        .clipShape(.rect(cornerRadius: 10))
        .background(
          ZStack {
            Rectangle()
              .fill(.placeholder)
            .clipShape(.rect(cornerRadius: 10))
            Image(systemName: "photo")
              .font(.system(size: 50))
              .foregroundStyle(.secondary)
          }
        )
    }
  }
}

#Preview {
  POICard(poi: PointOfInterest.sampleData)
}
