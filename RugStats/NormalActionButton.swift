//
//  NormalActionButton.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/03.
//

import SwiftUI

struct NormalActionButton: View {
    @State var timeline: [TimelineItem]
    var teamName: String
    var actionName: String
    var gameTime: TimeInterval
    
    var body: some View {
        let count = timeline.count(where: {$0.actorName == teamName && $0.actionName == actionName})
        Button("\(teamName) \(actionName) \(count)"){
            timeline.append(TimelineItem(timestamp: Date(), gameTime: gameTime, actorName: teamName, actionName: actionName))
        }.buttonStyle(.borderedProminent)
    }
}

#Preview {
    NormalActionButton(timeline: [], teamName: "チーム1", actionName: "トライ", gameTime: TimeInterval(100))
}
