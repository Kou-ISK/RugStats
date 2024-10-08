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
}
