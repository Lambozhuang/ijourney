//
//  WelcomeFormView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-06-11.
//

import SwiftUI

struct WelcomeFormView: View {
  
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var profileViewModel: ProfileViewModel
  @EnvironmentObject var navigationState: NavigationState
 
  @State private var newProfile: Profile = Profile(name: "", birthday: .now)
  
  var body: some View {
    NavigationStack {
      Form {
        Text("Welcome to iJourney! \n\nThis is your first time launching so we need to know a bit more about you!")
        Section {
          TextField(text: $newProfile.name, prompt: Text("Name")) {
            Text("Name")
          }
          DatePicker("Birthday", selection: $newProfile.birthday, displayedComponents: [.date])
        } header: {
          Text("Personal Information")
        }
        
        Section {
          Picker("Primary Language", selection: $newProfile.primaryLanguage) {
            ForEach(MajorLanguage.allCases) { language in
              Text(language.displayName).tag(language)
            }
          }
          Picker("Secondary Language", selection: $newProfile.secondaryLangauge) {
            ForEach(MajorLanguage.allCases) { language in
              Text(language.displayName).tag(language)
            }
          }
        } header: {
          Text("Additional Information")
        }
        
        Section {
          Button("Confirm") {
            profileViewModel.profile = newProfile
            navigationState.setHasLaunchedBefore()
            navigationState.isFirstLaunch = false
          }
          .disabled(newProfile.name == "")
        }
      }
      .navigationTitle("Add Profile")
      .navigationBarTitleDisplayMode(.large)
    }
    .interactiveDismissDisabled()
  }
}

#Preview {
  WelcomeFormView()
    .environmentObject(ProfileViewModel())
    .environmentObject(NavigationState())
}
