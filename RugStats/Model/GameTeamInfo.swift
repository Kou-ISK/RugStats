//
//  GameTeamInfo.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/08.
//

import Foundation
import SwiftData

@Model
final class GameTeamInfo: Identifiable {
    var teamName: String
    var teamColor: ColorItem?
    var players: [OrderedPlayerItem]  // 順序付きの選手配列
    
    // 背番号は常に1〜25とする
    static let maxPlayers = 25
    
    init(teamName: String) {
        self.teamName = teamName
        self.players = []
    }
    
    // 追加順に並べ替えて取得する関数
    func orderedPlayers() -> [PlayerItem] {
        return players.sorted(by: { $0.orderId < $1.orderId }).map { $0.player }
    }
    
    // 順序を考慮して選手を追加・削除
    func togglePlayer(_ player: PlayerItem) {
        if let index = players.firstIndex(where: { $0.player == player }) {
            players.remove(at: index)
        } else if players.count < GameTeamInfo.maxPlayers {
            let nextOrder = (players.map { $0.orderId }.max() ?? -1) + 1
            let orderedPlayer = OrderedPlayerItem(orderId: nextOrder, player: player)
            players.append(orderedPlayer)
        }
    }
}
