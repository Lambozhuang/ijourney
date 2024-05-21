//
//  GenerateItineraryView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-18.
//

import SwiftUI

struct GenerateItineraryView: View {
  
  @Environment(\.dismiss) var dismiss
  
  @EnvironmentObject var profileViewModel: ProfileViewModel
  @EnvironmentObject var itineraryViewModel: ItineraryViewModel
  
  @State private var showDiscardAlert = false
  @State private var showEditInterestLevel = false
  @State private var navigateToNewItineraryView = false
  
  @State private var startDate: Date = .now {
    didSet {
      if endDate < Calendar.current.date(byAdding: .day, value: 3, to: startDate)! {
        endDate = Calendar.current.date(byAdding: .day, value: 3, to: startDate)!
      }
    }
  }
  @State private var endDate: Date = Calendar.current.date(byAdding: .day, value: 3, to: .now)!
  
  @State private var userPrompt = ""
  
  var city: City
  
  var body: some View {
    NavigationStack {
      List {
        Section {
          Image(city.name)
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: 150)
        }
        
        Section {
          LabeledContent("Destination Country", value: city.countryName)
          LabeledContent("Destination City", value: city.name)
        } header: {
          Text("Destination")
        }
        
        Section {
          DatePicker("Start Date", selection: $startDate, in: Date()..., displayedComponents: [.date])
          DatePicker("End Date", selection: $endDate, in: startDate...(Calendar.current.date(byAdding: .day, value: 6, to: startDate)!), displayedComponents: [.date])
        } header: {
          Text("Time")
        }
        
        Section {
          Button {
            showEditInterestLevel = true
          } label: {
            Text("Edit Interest Level")
          }
        } header: {
          Text("Additional Information")
        }
      }
      .disabled(itineraryViewModel.isLoadingNewItinerary)
      .navigationTitle("Generate Itinerary")
      .navigationBarTitleDisplayMode(.large)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel", role: .cancel) {
            showDiscardAlert = true
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button("Create") {
            createItinerary()
          }
          .disabled(itineraryViewModel.isLoadingNewItinerary)
        }
      }
      .navigationDestination(isPresented: $navigateToNewItineraryView) {
        NewItineraryView(userPrompt: userPrompt, startDate: startDate, endDate: endDate)
      }
    }
    .confirmationDialog("Are you sure?", isPresented: $showDiscardAlert) {
      Button("Discard Changes", role: .destructive) {
        dismiss()
      }
    }
    .sheet(isPresented: $showEditInterestLevel) {
      EditInterestLevel(currentInterests: $profileViewModel.profile.interests)
    }
  }
  
  private func createItinerary() {
    userPrompt = itineraryViewModel.composeUserPrompt(city: city, startDate: startDate, endDate: endDate, interests: profileViewModel.profile.interests)
    itineraryViewModel.isLoadingNewItinerary = true
    navigateToNewItineraryView = true
  }
}

#Preview {
  struct Preview: View {
    @StateObject var itineraryViewModel = ItineraryViewModel(service: ItineraryService(networkService: TestNetworkService()))
    var body: some View {
      GenerateItineraryView(city: City(name: "Paris", countryName: "France"))
        .environmentObject(ProfileViewModel())
        .environmentObject(itineraryViewModel)
    }
  }
  return Preview()
}
 
