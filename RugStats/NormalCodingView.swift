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
            ForEach(actionList, id:\.self){actionName in
                HStack{
                    NormalActionButton(timeline: gameInfo.timeline, teamName: gameInfo.team1Name, actionName: actionName, gameTime: gameTime)
                    Spacer()
                    NormalActionButton(timeline: gameInfo.timeline, teamName: gameInfo.team1Name, actionName: actionName, gameTime: gameTime)
                }
            }
            // TODO テーブルが表示されない問題に対処する
            NormalStatsView(timeline: gameInfo.timeline)
        }
    }
}

#Preview {
    NormalCodingView(gameInfo: GameItem(timestamp: Date(), team1Name: "チーム1", team2Name: "チーム2"), gameTime: TimeInterval(100))
}
