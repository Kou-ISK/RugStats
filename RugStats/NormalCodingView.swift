//
//  NormalCodingView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/03.
//

import SwiftUI

struct NormalCodingView: View {
    @State var gameInfo: GameItem
    @State var gameTime: TimeInterval
    
    var actionList = ["スクラム", "ラインアウト", "ペナルティ", "トライ", "コンバージョンキック", "ペナルティーゴール"]
    
    var body: some View {
        VStack{
            // アクションボタン
            ForEach(actionList, id:\.self){actionName in
                HStack{
                    NormalActionButton(timeline: $gameInfo.timeline, teamName: gameInfo.team1Name, actionName: actionName, gameTime: gameTime)
                    Spacer()
                    NormalActionButton(timeline: $gameInfo.timeline, teamName: gameInfo.team2Name, actionName: actionName, gameTime: gameTime)
                }
            }
            // スタッツを表示
            NormalStatsView(timeline: $gameInfo.timeline)
        }
    }
}

#Preview {
    NormalCodingView(gameInfo: GameItem(timestamp: Date(), team1Name: "チーム1", team2Name: "チーム2"), gameTime: TimeInterval(100))
}
