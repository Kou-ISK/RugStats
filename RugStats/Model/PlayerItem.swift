//
//  PlayerItem.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/08.
//

import Foundation
import SwiftData

@Model
final class PlayerItem: Identifiable {
    var id = UUID()
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
