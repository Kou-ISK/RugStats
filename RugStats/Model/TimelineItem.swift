//
//  TimelineItem.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import Foundation
import SwiftData

@Model
final class TimelineItem {
    var timestamp: Date // 実際の時刻
    var gameTime: TimeInterval // 試合中断を加味した時間
    var actorName: String // チーム名 or 選手名が入る
    var actionName: String
    var actionLabels: [String]? // より良いラベルの持ち方がないか検討する
    // アクション開始時のX座標
    var startXcoord: Int? // -5~75の範囲
    // アクション開始時のX座標
    var startYcoord: Int? // -10~110の範囲
    // アクション終了時のX座標
    var endXcoord: Int? // -5~75の範囲
    // アクション終了時のX座標
    var endYcoord: Int? // -10~110の範囲
    
    @Relationship var game: GameItem
    
    // CodingView初期描画時に初期化
    init(game: GameItem, timestamp: Date, gameTime: TimeInterval, actorName: String, actionName: String) {
        self.game = game
        self.timestamp = timestamp
        self.gameTime = gameTime
        self.actorName = actorName
        self.actionName = actionName
    }
}
