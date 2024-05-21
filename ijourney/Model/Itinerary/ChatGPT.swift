//
//  ChatGPT.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-20.
//

import Foundation

struct ChatMessage: Codable {
  let role: String
  let content: String
}

struct ChatRequest: Codable {
  let messages: [ChatMessage]
}

struct ChatResponse: Codable {
  struct Choice: Codable {
    let message: ChatMessage
  }
  let choices: [Choice]
}
