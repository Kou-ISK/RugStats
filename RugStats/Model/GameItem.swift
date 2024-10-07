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
    var team1Name: String
    var team2Name: String
    var fieldName: String
    var basicInfo: String
    
    @Relationship
    var timeline: [TimelineItem]
    
    init(date: Date, team1Name: String, team2Name: String) {
        self.date = date
        self.team1Name = team1Name
        self.team2Name = team2Name
        self.fieldName = ""
        self.basicInfo = ""
        self.timeline = []
    }
    
    init(date: Date, team1Name: String, team2Name: String, fieldName: String, basicInfo: String) {
        self.date = date
        self.team1Name = team1Name
        self.team2Name = team2Name
        self.fieldName = fieldName
        self.basicInfo = basicInfo
        self.timeline = []
    }
}
