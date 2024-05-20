//
//  EditProfile.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import SwiftUI

struct EditProfile: View {
  
  @Environment(\.dismiss) var dismiss
  
  @State private var showDiscardAlert = false
  @Binding var showEditProfile: Bool
  @Binding var currentProfile: Profile
  @State private var newProfile: Profile = Profile(name: "", birthday: .now)
  
  var isChanged: Bool {
    newProfile != currentProfile
  }
  
  var body: some View {
    NavigationStack {
      Form {
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
      }
      .navigationTitle("Edit Profile")
      .navigationBarTitleDisplayMode(.large)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            showDiscardAlert = true
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button("Done") {
            currentProfile = newProfile
            dismiss()
          }
        }
      }
      .confirmationDialog("Are you sure?", isPresented: $showDiscardAlert) {
        Button("Discard Changes", role: .destructive) {
          dismiss()
        }
      }
      .onAppear {
        newProfile = currentProfile
      }
    }
    .interactiveDismissDisabled(isChanged)
  }
}

#Preview {
  EditProfile(showEditProfile: .constant(true), currentProfile: .constant(Profile(name: "", birthday: .now)))
}
