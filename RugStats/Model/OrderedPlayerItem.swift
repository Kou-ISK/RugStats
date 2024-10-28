//
//  OrderedPlayerItem.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/29.
//

import Foundation
import SwiftData

@Model
final class OrderedPlayerItem: Identifiable {
    var id =  UUID()
    var orderId: Int
    var player: PlayerItem  // 選手データ

    init(orderId: Int, player: PlayerItem) {
        self.orderId = orderId
        self.player = player
    }
}
