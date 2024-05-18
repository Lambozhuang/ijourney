//
//  EditProfile.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import SwiftUI

struct EditProfile: View {
  
  @Environment(\.dismiss) var dismiss
  
  @State private var name: String = ""
  @State private var birthday: Date = .now
  @State private var selectedLanguage1: MajorLanguage = .english
  @State private var selectedLanguage2: MajorLanguage = .chinese
  @State private var showDiscardAlert = false
  @Binding var showEditProfile: Bool
  
  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField(text: $name, prompt: Text("Name")) {
            Text("Name")
          }
          DatePicker("Birthday", selection: $birthday, displayedComponents: [.date])
        } header: {
          Text("Personal Information")
        }
        
        Section {
          Picker("Primary Language", selection: $selectedLanguage1) {
            ForEach(MajorLanguage.allCases) { language in
              Text(language.displayName).tag(language)
            }
          }
          Picker("Secondary Language", selection: $selectedLanguage2) {
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
            
          }
        }
      }
      .confirmationDialog("Are you sure?", isPresented: $showDiscardAlert) {
        Button("Discard Changes", role: .destructive) {
          dismiss()
        }
      }
    }
  }
}

#Preview {
  EditProfile(showEditProfile: .constant(true))
}
