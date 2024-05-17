//
//  ItineraryError.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import Foundation

enum ItineraryError: Error {
  case missingData
  case networkError
  case unexpectedError(error: Error)
}
