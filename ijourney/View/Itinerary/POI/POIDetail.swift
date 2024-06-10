//
//  POIDetail.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import SwiftUI
import MapKit

struct POIDetail: View {
  
  @State private var latitude: Double?
  @State private var longitude: Double?
  
  @State private var isLoading = true
  @State private var errorMessage: String? = ""
  
  @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion())

  @State var poi: PointOfInterest
  
  let itinerary: Itinerary
  
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
        
        HStack(alignment: .lastTextBaseline) {
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
        
        if !isLoading {
          if let latitude = poi.latitude, let longitude = poi.longitude {
            HStack(alignment: .firstTextBaseline) {
              Text("Location")
                .font(.title3)
                .bold()
              Spacer()
              Button {
                openInMaps()
              } label: {
                Text("View in Maps")
              }
            }
            
            //          Text("\(latitude), \(longitude)")
            
            Map(position: $cameraPosition) {
              Marker(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)) {
                Text("\(poi.name)")
              }
            }
            .frame(height: 250)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.bottom, 30)
            .onAppear {
              cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.0035, longitudeDelta: 0.0035)))
            }
          }
        } else {
          if errorMessage == nil {
            ProgressView()
              .padding(.bottom, 30)
          } else {
            Text(errorMessage ?? "")
          }
        }
        
        if let description = poi.description {
          Text("Description")
            .font(.title3)
            .bold()
            .padding(.bottom, 5)
          Text(description)
        }
        Spacer()
      }
      .padding()
    }
    .navigationBarTitleDisplayMode(.inline)
    .toolbarBackground(.automatic, for: .navigationBar)
    .ignoresSafeArea(edges: .top)
    .task {
      await fetchCoordinates(for: poi.name, city: itinerary.cityName!, country: itinerary.countryName!)
    }
  }
  
  private func fetchCoordinates(for place: String, city: String, country: String) async {
    errorMessage = nil
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = "\(place), \(city), \(country)"
    
    let search = MKLocalSearch(request: request)
    do {
      let response = try await search.start()
      if let mapItem = response.mapItems.first {
        let coordinate = mapItem.placemark.coordinate
        poi.latitude = coordinate.latitude
        poi.longitude = coordinate.longitude
      } else {
        errorMessage = "No locations found."
      }
    } catch {
      errorMessage = "Error fetching location: \(error.localizedDescription)"
    }
    withAnimation {
      isLoading = false
    }
  }
  
  private func openInMaps() {
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = "\(poi.name), \(itinerary.cityName!), \(itinerary.countryName!)"
    request.region = MKCoordinateRegion(MKMapRect.world)
    
    let search = MKLocalSearch(request: request)
    search.start { response, error in
      guard let response = response else {
        print("MKLocalSearch response error")
        return
      }
      
      // Filter results to find the POI with the exact country
      let filteredItems = response.mapItems.filter { item in
        if let country = item.placemark.country {
          return country == itinerary.countryName
        }
        return false
      }
      
      guard let mapItem = filteredItems.first else {
        print("No matching results for the POI")
        return
      }
      
      mapItem.openInMaps(launchOptions: [
        MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: mapItem.placemark.coordinate),
        MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: MKCoordinateSpan(latitudeDelta: 0.0035, longitudeDelta: 0.0035))
      ])
    }
  }

}

#Preview {
  POIDetail(poi: PointOfInterest.sampleData, itinerary: Itinerary.sampleData[0])
}
