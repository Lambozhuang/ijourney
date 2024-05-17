//
//  CityDetail.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import SwiftUI
import MapKit
import Glur

struct CityDetail: View {
  var city: City
  
  var body: some View {
    
    ScrollView {
      ZStack(alignment: .bottomLeading) {
        
        Image(city.name)
          .resizable()
          .scaledToFill()
          .frame(width: UIScreen.main.bounds.width, height: 300)
          .glur(radius: 2, direction: .up)
          .ignoresSafeArea()
        
        LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.75), Gradient.Stop(color: Color(UIColor.systemBackground), location: 0.95)], startPoint: .top, endPoint: .bottom)
          .frame(height: 300)
          .ignoresSafeArea()
        
        HStack(alignment: .firstTextBaseline) {
          Text(city.name)
            .font(.system(.largeTitle, design: .serif))
            .fontWeight(.bold)
          Text(city.countryName)
            .font(.body)
            .padding(.leading, 10)
          Spacer()
          Menu {
            Button("Option 1", action: {print("1") })
            Button("Option 2", action: {print("2") })
          } label: {
            Image(systemName: "ellipsis.circle")
              .font(.title2)
          }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
        .offset(y: 25)
      }
      .padding(.bottom, 5)
      VStack(alignment: .leading) {
        
        Text("Location")
          .font(.title3)
          .bold()
          .padding(.bottom, 5)
        Map()
          .frame(height: 250)
          .clipShape(.rect(cornerRadius: 10))
          .padding(.bottom, 30)
        
        Text("Description")
          .font(.title3)
          .bold()
          .padding(.bottom, 5)
        Text(city.description)
        Spacer()
      }
      .padding()
    }
    .navigationBarTitleDisplayMode(.inline)
    .ignoresSafeArea()
    .toolbarBackground(.automatic, for: .navigationBar)
  }
}

#Preview {
  CityDetail(city: City.sampleData[0])
}
