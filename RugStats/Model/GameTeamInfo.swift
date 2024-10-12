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
    var players: [PlayerItem]
    
    // 背番号は常に1〜25とする
    static let maxPlayers = 25
    
    init(teamName: String, players: [PlayerItem]) {
        self.teamName = teamName
        self.players = players
    }
    
    init(teamName: String) {
        self.teamName = teamName
        self.players = []
    }
    
    // 背番号で選手を取得するための関数（1-25の範囲で入力）
    func player(forNumber number: Int) -> PlayerItem? {
        guard number >= 1 && number <= GameTeamInfo.maxPlayers else {
            return nil
        }
        return players[number - 1] // 配列は0ベースなので-1する
    }
    
    // 背番号で選手をセットする関数
    func setPlayer(_ player: PlayerItem, forNumber number: Int) {
        guard number >= 1 && number <= GameTeamInfo.maxPlayers else {
            return
        }
        players[number - 1] = player
    }
}
