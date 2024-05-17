//
//  CityCard.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import SwiftUI

struct CityCard: View {
  
  var city: City
  
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      VStack {
        HStack {
          VStack(alignment: .leading) {
            Text(city.name)
              .font(.system(.title, design: .serif))
              .fontWeight(.bold)
            Text(city.countryName)
          }
          
          Spacer()
        }
        .shadow(radius: 2)
        .padding([.leading, .trailing])
        
        Image(city.name)
          .resizable()
          .scaledToFill()
          .frame(width: (UIScreen.main.bounds.width - 70), height: 150)
          .clipShape(.rect(cornerRadius: 10))
      }
      
    }
    .frame(width: (UIScreen.main.bounds.width - 40), height: 250)
    .clipShape(.rect(cornerRadius: 20))
    .background(
      Rectangle()
        .fill(.fill)
        .clipShape(.rect(cornerRadius: 10))
    )
  }
}

#Preview {
  CityCard(city: City.sampleData[0])
}
