//
//  Double+clamped.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-22.
//

import Foundation

extension Double {
  func clamped(to range: ClosedRange<Double>) -> Double {
    return min(max(self, range.lowerBound), range.upperBound)
  }
}
