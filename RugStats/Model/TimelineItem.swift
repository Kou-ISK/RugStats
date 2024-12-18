//
//  TimelineItem.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import Foundation
import SwiftData

@Model
final class TimelineItem: Identifiable {
    var id = UUID()
    var startTimestamp: Date // 実際の時刻
    var endTimeSstamp: Date?
    var startGameClock: TimeInterval // 試合中断を加味した時間
    var endGameClock: TimeInterval? // アドバンスモードで使用
    var actorName: String // チーム名 or 選手名が入る
    var actionName: String
    var actionLabels: [ActionLabelItem]
    // アクション開始時のX座標
    var startXcoord: Int? // -5~75の範囲
    // アクション開始時のX座標
    var startYcoord: Int? // -10~110の範囲
    // アクション終了時のX座標
    var endXcoord: Int? // -5~75の範囲
    // アクション終了時のX座標
    var endYcoord: Int? // -10~110の範囲
    
    // CodingView初期描画時に初期化
    init(startTimestamp: Date, startGameClock: TimeInterval, actorName: String, actionName: String) {
        self.startTimestamp = startTimestamp
        self.startGameClock = startGameClock
        self.actorName = actorName
        self.actionName = actionName
        self.actionLabels = []
    }
    
    init(startTimestamp: Date, startGameClock: TimeInterval, actorName: String, actionName: String, actionLabels: [ActionLabelItem]) {
        self.startTimestamp = startTimestamp
        self.startGameClock = startGameClock
        self.actorName = actorName
        self.actionName = actionName
        self.actionLabels = actionLabels
    }
    
    init(startTimestamp: Date, startGameClock: TimeInterval, endGameClock: TimeInterval, actorName: String, actionName: String) {
        self.startTimestamp = startTimestamp
        self.startGameClock = startGameClock
        self.endGameClock = endGameClock
        self.actorName = actorName
        self.actionName = actionName
        self.actionLabels = []
    }
    
    init(startTimestamp: Date, startGameClock: TimeInterval, endGameClock: TimeInterval, actorName: String, actionName: String, startXcoord: Int, startYcoord: Int, endXcoord: Int, endYcoord: Int) {
        self.startTimestamp = startTimestamp
        self.startGameClock = startGameClock
        self.endGameClock = endGameClock
        self.actorName = actorName
        self.actionName = actionName
        self.actionLabels = []
        self.startXcoord = startXcoord
        self.startYcoord = startYcoord
        self.endXcoord = endXcoord
        self.endYcoord = endYcoord
    }
}
