//
//  GICountryListView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import SwiftUI

struct GICountryListView: View {
  
  @Binding var isPresentingSheet: Bool
  @State private var showDiscardAlert = false
  @State private var searchText = ""
  
  @State private var itinerary = Itinerary()
  @State private var allCountries: [Country] = []
  
  var filteredCountries: [Country] {
    if searchText.isEmpty {
      return allCountries
    } else {
      return allCountries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
  }
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(filteredCountries) { country in
          NavigationLink(destination: GICityListView(country: country)) {
            Text(country.name)
          }
        }
      }
      .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
      .navigationTitle("Choose a Country")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar{
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            showDiscardAlert = true
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button("Add") {
            isPresentingSheet = false
          }
        }
      }
      .confirmationDialog("Are you sure?", isPresented: $showDiscardAlert) {
        Button("Discard Changes", role: .destructive) {
          isPresentingSheet = false
        }
      }
    }
    .task {
      await loadCountries()
      print(allCountries.count)
    }
  }
  
  private func loadCountries() async {
    if let url = Bundle.main.url(forResource: "country-by-abbreviation", withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let decodedCountries = try JSONDecoder().decode([Country].self, from: data)
        allCountries = decodedCountries
      } catch {
        print("Error loading countries: \(error)")
      }
    }
  }
  

}

#Preview {
  GICountryListView(isPresentingSheet: .constant(true))
}
