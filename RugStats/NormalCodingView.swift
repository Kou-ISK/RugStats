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
    
    var actionList = ["スクラム", "ラインアウト", "ペナルティ", "トライ", "コンバージョンキック", "ペナルティーゴール"]
    
    var body: some View {
        VStack {
            // アクションボタン
            ForEach(actionList, id:\.self) { actionName in
                HStack {
                    NormalActionButton(timeline: $gameInfo.timeline, teamName: gameInfo.team1Name, actionName: actionName, gameClock: gameClock)
                    Spacer()
                    NormalActionButton(timeline: $gameInfo.timeline, teamName: gameInfo.team2Name, actionName: actionName, gameClock: gameClock)
                }
            }
            
            // スタッツを表示
            NormalStatsView(timeline: $gameInfo.timeline)
        }
    }
}
