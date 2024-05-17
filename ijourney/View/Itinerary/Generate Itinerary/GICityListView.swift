//
//  GICityListView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import SwiftUI

struct GICityListView: View {
  
  @Binding var isPresentingSheet: Bool
  @State private var isPresentingGenerateItinerary: Bool = false
  @State private var searchText = ""
  
  let country: Country
  @State private var cities: [City] = []
  @State private var selectedCity: City? = nil
  
  var filteredCities: [City] {
    if searchText.isEmpty {
      return cities
    } else {
      return cities.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
  }
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(filteredCities) { city in
          Button {
            selectedCity = city
          } label: {
            Text(city.name)
          }
          .tint(.primary)
        }
      }
      .navigationTitle("Choose a city")
      .navigationBarTitleDisplayMode(.inline)
      .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
    .onChange(of: selectedCity) { oldValue, newValue in
      if newValue != nil {
        isPresentingGenerateItinerary = true
      }
    }
    .task {
      await loadCities()
    }
    .fullScreenCover(isPresented: $isPresentingGenerateItinerary) {
      if let city = selectedCity {
        GenerateItineraryView(city: city)
      }
    }
  }
  
  private func loadCities() async {
    if let url = Bundle.main.url(forResource: "country-by-cities", withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let decodedData = try JSONDecoder().decode([CityWrapper].self, from: data)
        guard let cityWrapper = decodedData.first(where: { $0.country == country.name }) else {
          return
        }
        cities = cityWrapper.cities.map { City(name: $0, countryName: country.name) }
      } catch {
        print("Error loading cities: \(error)")
      }
    }
  }
  
  private struct CityWrapper: Codable {
    let country: String
    let cities: [String]
  }
}

#Preview {
  GICityListView(isPresentingSheet: .constant(true), country: Country(name: "China", abbreviation: "TC"))
}
