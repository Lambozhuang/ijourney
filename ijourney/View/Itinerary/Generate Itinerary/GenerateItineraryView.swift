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
  
  @State private var showDiscardAlert = false
  @State private var showEditInterestLevel = false
  
  @State private var startDate: Date = .now
  @State private var endDate: Date = .now

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
          DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
          DatePicker("End Date", selection: $endDate, displayedComponents: [.date])
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
            
          }
        }
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
}

#Preview {
  GenerateItineraryView(city: City(name: "Paris", countryName: "France"))
    .environmentObject(ProfileViewModel())
}
