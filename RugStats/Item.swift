//
//  Item.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
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
