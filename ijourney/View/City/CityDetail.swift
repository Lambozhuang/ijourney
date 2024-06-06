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
  
  @EnvironmentObject var navigationState: NavigationState
  
  @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion())
  
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
            .foregroundStyle(.secondary)
            .padding(.leading, 10)
          Spacer()
          Menu {
            Button("Create Itinerary") {
              navigationState.showGenerateItinerarySheet2 = true
            }
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
        
        if let latitude = city.latitude, let longitude = city.longitude {
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
          
          Map(position: $cameraPosition)
            .frame(height: 250)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.bottom, 30)
            .onAppear {
              cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
            }
        }
        
        Text("Description")
          .font(.title3)
          .bold()
          .padding(.bottom, 5)
        Text(city.description ?? "")
        Spacer()
      }
      .padding()
    }
    .navigationBarTitleDisplayMode(.inline)
    .toolbarBackground(.automatic, for: .navigationBar)
    .ignoresSafeArea(edges: .top)
    .fullScreenCover(isPresented: $navigationState.showGenerateItinerarySheet2) {
      GenerateItineraryView(city: city)
    }
  }
}

#Preview {
  CityDetail(city: City.sampleData[1])
    .environmentObject(ItineraryViewModel(service: ItineraryService(networkService: TestItineraryNetworkService())))
}
