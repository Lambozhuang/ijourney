//
//  ChatGPT.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-20.
//

import Foundation

struct ChatGPTRequest: Codable {
  let prompt: String
  let max_tokens: Int
  let temperature: Double
}

struct ChatGPTResponse: Codable {
  struct Choice: Codable {
    let text: String
  }
  let choices: [Choice]
}
