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
    
    @State private var team1Color: Color = Color.pink
    @State private var team2Color: Color = Color.indigo
    
    var body: some View {
        VStack {
            ForEach(actionList, id:\.self) { actionName in
                HStack(alignment: .center){
                    // TODO: ボタンの色をteam.teamColorにする
                    NormalActionButton(timeline: $gameInfo.timeline, teamName: gameInfo.team1.teamName, actionName: actionName, gameClock: gameClock).tint(team1Color)
                    NormalActionButton(timeline: $gameInfo.timeline, teamName: gameInfo.team2.teamName, actionName: actionName, gameClock: gameClock).tint(team2Color)
                }
            }
            
            // スタッツを表示
            NormalStatsTableView(timeline: $gameInfo.timeline)
        }.onAppear{
            if let team1ColorItem = gameInfo.team1.teamColor {
                team1Color = Color(cgColor: CGColor(
                    red: team1ColorItem.red,
                    green: team1ColorItem.green,
                    blue: team1ColorItem.blue,
                    alpha: team1ColorItem.alpha
                ))
            } else {
                team1Color = .pink // Fallback color
            }

            if let team2ColorItem = gameInfo.team2.teamColor {
                team2Color = Color(cgColor: CGColor(
                    red: team2ColorItem.red,
                    green: team2ColorItem.green,
                    blue: team2ColorItem.blue,
                    alpha: team2ColorItem.alpha
                ))
            } else {
                team2Color = .indigo // Fallback color
            }
        }
    }
}

#Preview{
    NormalCodingView(gameInfo: .constant(GameItem(date: Date(), team1Name: "チーム1", team2Name: "チーム2")), gameClock: .constant(TimeInterval(800)))
}
