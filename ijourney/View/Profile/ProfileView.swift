//
//  ProfileView.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import SwiftUI

struct ProfileView: View {
  
  var profile: Profile
  
  var body: some View {
    NavigationStack {
      List {
        Section {
          HStack {
            Image(systemName: "person.circle")
              .font(.system(size: 70))
            VStack(alignment: .leading) {
              Text(profile.name)
                .font(.largeTitle)
              Text(profile.birthday.formatted(date: .numeric, time: .omitted))
                .font(.title3)
            }
            Spacer()
          }
          VStack(alignment: .leading) {
            Text("Additional Information")
              .bold()
            Text("Languages: ")
          }
          
        }
        
        Section {
          NavigationLink {
            EditProfile()
          } label: {
            Text("Edit Profile")
          }
          NavigationLink {
            EditInterestLevel()
          } label: {
            Text("Edit Interest Level")
          }
        }
        
        Section {
          NavigationLink {
            Text("About")
          } label: {
            Text("About")
          }
        }
        
      }
      .navigationTitle("My Profile")
    }
  }
}

#Preview {
  ProfileView(profile: Profile.sampleData)
}
