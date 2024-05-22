//
//  CityError.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-22.
//

import Foundation

enum CityError: Error {
  case missingData
  case networkError
  case decodingError
  case unexpectedError(error: Error)
}
