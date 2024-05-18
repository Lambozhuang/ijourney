//
//  EditProfile.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import SwiftUI

struct EditProfile: View {
  
  @State private var name: String = ""
  @State private var birthday: Date = .now
  
  var body: some View {
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
//        Picker("First Language", selection: <#T##Binding<SelectionValue>#>)
      } header: {
        Text("Additional Information")
      }
    }
    .navigationTitle("Edit Profile")
    .navigationBarTitleDisplayMode(.large)
  }
}

#Preview {
  EditProfile()
}
