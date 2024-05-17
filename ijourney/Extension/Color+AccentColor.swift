//
//  Color+AccentColor.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-16.
//

import Foundation
import SwiftUI

extension Color {
  static var primaryTintColor: Color {
    // Use a conditional statement to switch between light and dark mode colors
    if UITraitCollection.current.userInterfaceStyle == .dark {
      return Color.green // Dark mode tint color
    } else {
      return Color.blue // Light mode tint color
    }
  }
}
