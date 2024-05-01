//
//  Item.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-01.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
