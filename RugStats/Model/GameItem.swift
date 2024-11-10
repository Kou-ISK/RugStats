//
//  GameItem.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import Foundation
import SwiftData

@Model
final class GameItem {
    var date: Date
    var fieldName: String
    var basicInfo: String
    
    var team1: GameTeamInfo
    var team2: GameTeamInfo
    
    @Relationship
    var timeline: [TimelineItem]
    
    init(date: Date, team1Name: String, team2Name: String) {
        self.date = date
        self.fieldName = ""
        self.basicInfo = ""
        self.timeline = []
        self.team1 = GameTeamInfo(teamName: team1Name)
        self.team2 = GameTeamInfo(teamName: team2Name)
    }
    
    init(date: Date, team1Name: String, team2Name: String, fieldName: String, basicInfo: String) {
        self.date = date
        self.team1 = GameTeamInfo(teamName: team1Name)
        self.team2 = GameTeamInfo(teamName: team2Name)
        self.fieldName = fieldName
        self.basicInfo = basicInfo
        self.timeline = []
    }
    
    // JSON変換用メソッド
    func toJSON() -> String? {
        // JSON用のエンコード可能な構造体に変換
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601 // Dateのエンコーディング方式を設定
        
        do {
            // GameItemをエンコード可能な構造体に変換
            let gameItemCodable = GameItemCodable(from: self)
            let jsonData = try jsonEncoder.encode(gameItemCodable)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("Failed to encode GameItem to JSON:", error)
            return nil
        }
    }
}

// JSON用の構造体
struct GameItemCodable: Codable {
    var date: Date
    var fieldName: String
    var basicInfo: String
    var team1: GameTeamInfoCodable
    var team2: GameTeamInfoCodable
    var timeline: [TimelineItemCodable]
    
    init(from gameItem: GameItem) {
        self.date = gameItem.date
        self.fieldName = gameItem.fieldName
        self.basicInfo = gameItem.basicInfo
        self.team1 = GameTeamInfoCodable(from: gameItem.team1)
        self.team2 = GameTeamInfoCodable(from: gameItem.team2)
        self.timeline = gameItem.timeline.map { TimelineItemCodable(from: $0) }
    }
}

struct GameTeamInfoCodable: Codable {
    var teamName: String
    var players: [OrderedPlayerItemCodable]
    
    init(from gameTeamInfo: GameTeamInfo) {
        self.teamName = gameTeamInfo.teamName
        self.players = gameTeamInfo.players.map { OrderedPlayerItemCodable(from: $0) }
    }
}

struct OrderedPlayerItemCodable: Codable {
    var orderId: Int
    var playerName: String
    
    init(from orderedPlayerItem: OrderedPlayerItem) {
        self.orderId = orderedPlayerItem.orderId
        self.playerName = orderedPlayerItem.player.name
    }
}

struct TimelineItemCodable: Codable {
    var startTimestamp: Date
    var startGameClock: TimeInterval
    var endGameClock: TimeInterval?
    var actorName: String
    var actionName: String
    var startXcoord: Int?
    var startYcoord: Int?
    var endXcoord: Int?
    var endYcoord: Int?
    
    init(from timelineItem: TimelineItem) {
        self.startTimestamp = timelineItem.startTimestamp
        self.startGameClock = timelineItem.startGameClock
        self.endGameClock = timelineItem.endGameClock
        self.actorName = timelineItem.actorName
        self.actionName = timelineItem.actionName
        self.startXcoord = timelineItem.startXcoord
        self.startYcoord = timelineItem.startYcoord
        self.endXcoord = timelineItem.endXcoord
        self.endYcoord = timelineItem.endYcoord
    }
}
