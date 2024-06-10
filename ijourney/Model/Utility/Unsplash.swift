//
//  Unsplash.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-06-09.
//

import Foundation

struct UnsplashResponse: Codable {
  let results: [UnsplashImage]
}

struct UnsplashImage: Codable {
  let urls: UnsplashImageURLs
}

struct UnsplashImageURLs: Codable {
  let regular: String
}
