//
//  TeamItem.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/08.
//

import Foundation
import SwiftData

@Model
final class TeamItem: Identifiable {
    var id = UUID()
    var name: String
    var teamColor: ColorItem?
    
    @Relationship
    var players: [PlayerItem]
    
    init(name: String) {
        self.name = name
        self.players = []
    }
}
