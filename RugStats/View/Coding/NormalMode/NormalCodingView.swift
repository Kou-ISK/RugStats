//
//  NormalCodingView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/03.
//

import SwiftUI

struct NormalCodingView: View {
    @Binding var gameInfo: GameItem
    @Binding var gameClock: TimeInterval // ストップウォッチの経過時間
    
    var body: some View {
        VStack {
            ForEach(actionList, id:\.self) { actionName in
                HStack(alignment: .center){
                    NormalActionButton(timeline: $gameInfo.timeline, teamName: gameInfo.team1Name, actionName: actionName, gameClock: gameClock).tint(.red)
                    NormalActionButton(timeline: $gameInfo.timeline, teamName: gameInfo.team2Name, actionName: actionName, gameClock: gameClock)
                }
            }
            
            // スタッツを表示
            NormalStatsTableView(timeline: $gameInfo.timeline)
        }
    }
}

#Preview{
    NormalCodingView(gameInfo: .constant(GameItem(timestamp: Date(), team1Name: "チーム1", team2Name: "チーム2")), gameClock: .constant(TimeInterval(800)))
}
