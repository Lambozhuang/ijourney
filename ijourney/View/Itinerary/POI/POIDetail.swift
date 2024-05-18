//
//  POIDetail.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import SwiftUI
import MapKit

struct POIDetail: View {
  var poi: PointOfInterest
  var body: some View {
    ScrollView {
      ZStack(alignment: .bottomLeading) {
        
        Image(poi.name)
          .resizable()
          .scaledToFill()
          .frame(width: UIScreen.main.bounds.width, height: 300)
          .glur(radius: 2, direction: .up)
          .ignoresSafeArea()
        
        LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.75), Gradient.Stop(color: Color(UIColor.systemBackground), location: 0.95)], startPoint: .top, endPoint: .bottom)
          .frame(height: 300)
          .ignoresSafeArea()
        
        HStack(alignment: .firstTextBaseline) {
          Text(poi.name)
            .font(.system(.largeTitle, design: .serif))
            .fontWeight(.bold)
          Spacer()
          Text(poi.type.rawValue)
            .font(.body)
            .padding(.leading, 10)
            .foregroundStyle(.secondary)
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
        Text(poi.description ?? "")
        Spacer()
      }
      .padding()
    }
    .navigationBarTitleDisplayMode(.inline)
    .toolbarBackground(.automatic, for: .navigationBar)
    .ignoresSafeArea(edges: .top)
  }
}

#Preview {
  POIDetail(poi: PointOfInterest.sampleData)
}
