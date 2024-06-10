//
//  ItineraryDetail.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-07.
//

import SwiftUI
import MapKit
import Glur

struct ItineraryDetail: View {
  
  @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion())

  var isPreview: Bool
  var itinerary: Itinerary
  
  var body: some View {
    
    ScrollView {
      
      ZStack(alignment: .bottomLeading) {
        
        Image(itinerary.cityName ?? "")
          .resizable()
          .scaledToFill()
          .frame(width: UIScreen.main.bounds.width, height: 300)
          .glur(radius: 2, direction: .up)
        
        LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.75), Gradient.Stop(color: Color(UIColor.systemBackground), location: 0.95)], startPoint: .top, endPoint: .bottom)
          .frame(height: 300)
        
        HStack(alignment: .firstTextBaseline) {
          Text("Journey to \(itinerary.cityName ?? "")")
            .font(.system(.title, design: .serif))
            .fontWeight(.bold)
          Text(itinerary.countryName ?? "")
            .font(.body)
            .padding(.leading, 10)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
        .offset(y: 25)
        
      }
      
      VStack(alignment: .leading) {
        
        if let startDate = itinerary.startDate, let endDate = itinerary.endDate {
          Text("\(startDate.formatted(date: .abbreviated, time: .omitted)) - \(endDate.formatted(date: .abbreviated, time: .omitted))")
            .padding(.bottom, 10)
            .offset(y: -7)
            .foregroundStyle(.secondary)
        }
        
        if let latitude = itinerary.latitude, 
           let longitude = itinerary.longitude,
           let cityName = itinerary.cityName,
           let countryName = itinerary.countryName {
          HStack(alignment: .firstTextBaseline) {
            Text("Location")
              .font(.title3)
              .bold()
            Spacer()
            Button {
              openInMaps(cityName: cityName, countryName: countryName)
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
        
        Text("Itinerary")
          .font(.title3)
          .bold()
          .padding(.bottom, 5)
        
        ForEach(Array(itinerary.days.enumerated()), id: \.element.id) { index, day in
          VStack(alignment: .leading) {
            Text("Day \(index + 1)")
              .font(.body)
              .bold()
              .foregroundStyle(.secondary)
            POIList(day: day, itinerary: itinerary)
          }
          .padding(.bottom)
        }
        Spacer()
      }
      .padding()
    }
    .navigationBarTitleDisplayMode(.inline)
    .toolbarBackground(.automatic, for: .navigationBar)
    .ignoresSafeArea(edges: .top)
    .toolbar {
      ToolbarItem {
        if !isPreview {
          Menu {
            Button("Delete Itinerary", role: .destructive) {
              
            }
          } label: {
            Image(systemName: "ellipsis.circle")
          }
        }
      }
    }
  }
  
  private func openInMaps(cityName: String, countryName: String) {
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = "\(cityName), \(countryName)"
    
    request.region = MKCoordinateRegion(MKMapRect.world)
    
    let search = MKLocalSearch(request: request)
    search.start { response, error in
      guard let response = response else {
        print("MKLocalSearch response error")
        return
      }
      
      // Filter results to find the city with the exact name and country
      let filteredItems = response.mapItems.filter { item in
        print(item.placemark)
        if let locality = item.placemark.locality,
           let country = item.placemark.country {
          return locality == cityName && country == countryName
        }
        return false
      }
      
      guard let mapItem = filteredItems.first else {
        print("No matching results for the city")
        return
      }
      
      mapItem.openInMaps(launchOptions: [
        MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: mapItem.placemark.coordinate),
        MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
      ])
    }
  }
}



#Preview {
  ItineraryDetail(isPreview: false, itinerary: Itinerary.sampleData[0])
}
