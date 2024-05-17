//
//  CityDetail.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import SwiftUI
import Glur

struct CityDetail: View {
  var itinerary: Itinerary
  var body: some View {
    
    ScrollView {
      ZStack(alignment: .bottomLeading) {
        
        Image(itinerary.imageName!)
          .resizable()
          .scaledToFill()
          .frame(width: UIScreen.main.bounds.width, height: 300)
          .glur(radius: 2, direction: .up)
          .ignoresSafeArea()
        
        LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.75), Gradient.Stop(color: Color(UIColor.systemBackground), location: 0.95)], startPoint: .top, endPoint: .bottom)
          .frame(height: 300)
          .ignoresSafeArea()
        
        HStack(alignment: .firstTextBaseline) {
          Text(itinerary.cityName ?? "")
            .font(.system(.largeTitle, design: .serif))
            .fontWeight(.bold)
          Text(itinerary.countryName ?? "")
            .font(.body)
            .padding(.leading, 10)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
        .offset(y: 25)
        
      }
      
      VStack {
        
        
        Text("Rome (Italian and Latin: Roma, Italian: [ˈroːma] ⓘ) is the capital city of Italy. It is also the capital of the Lazio region, the centre of the Metropolitan City of Rome Capital, and a special comune (municipality) named Comune di Roma Capitale. With 2,860,009 residents in 1,285 km2 (496.1 sq mi),[2] Rome is the country's most populated comune and the third most populous city in the European Union by population within city limits. The Metropolitan City of Rome, with a population of 4,355,725 residents, is the most populous metropolitan city in Italy.[3] Its metropolitan area is the third-most populous within Italy.[5] Rome is located in the central-western portion of the Italian Peninsula, within Lazio (Latium), along the shores of the Tiber. Vatican City (the smallest country in the world)[6] is an independent country inside the city boundaries of Rome, the only existing example of a country within a city. Rome is often referred to as the City of Seven Hills due to its geographic location, and also as the \"Eternal City\". Rome is generally considered to be the cradle of Western civilization and Western Christian culture, and the centre of the Catholic Church.[7][8][9]Rome (Italian and Latin: Roma, Italian: [ˈroːma] ⓘ) is the capital city of Italy. It is also the capital of the Lazio region, the centre of the Metropolitan City of Rome Capital, and a special comune (municipality) named Comune di Roma Capitale. With 2,860,009 residents in 1,285 km2 (496.1 sq mi),[2] Rome is the country's most populated comune and the third most populous city in the European Union by population within city limits. The Metropolitan City of Rome, with a population of 4,355,725 residents, is the most populous metropolitan city in Italy.[3] Its metropolitan area is the third-most populous within Italy.[5] Rome is located in the central-western portion of the Italian Peninsula, within Lazio (Latium), along the shores of the Tiber. Vatican City (the smallest country in the world)[6] is an independent country inside the city boundaries of Rome, the only existing example of a country within a city. Rome is often referred to as the City of Seven Hills due to its geographic location, and also as the \"Eternal City\". Rome is generally considered to be the cradle of Western civilization and Western Christian culture, and the centre of the Catholic Church.[7][8][9]")
        
        
        Spacer()
      }
      .padding()
    }
    .navigationBarTitleDisplayMode(.inline)
    .ignoresSafeArea()
  }
}

#Preview {
  CityDetail(itinerary: Itinerary.sampleData[0])
}
