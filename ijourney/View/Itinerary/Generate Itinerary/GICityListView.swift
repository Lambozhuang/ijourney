//
//  GICityListView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import SwiftUI

struct GICityListView: View {
  
  let country: Country
  @State private var cities: [City] = []
  @State private var searchText = ""
  
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
          Text(city.name)
        }
      }
      .navigationTitle("Choose a city")
      .navigationBarTitleDisplayMode(.inline)
      .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
    .task {
      await loadCities()
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
  GICityListView(country: Country(name: "China", abbreviation: "TC"))
}
