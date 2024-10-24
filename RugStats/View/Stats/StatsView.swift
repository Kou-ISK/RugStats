//
//  StatsView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI

struct StatsView: View {
    @State var game: GameItem
    
    @State private var isNormalMode: Bool = true
    
    var body: some View {
        VStack {
            // スコア表示
            ScoreView(game: game)
            
            if(isNormalMode){
                NormalStatsTableView(timeline: $game.timeline)
            }else{
                AdvancedStatsView(timeline: $game.timeline)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isNormalMode.toggle()
                }){
                    Text(isNormalMode ? "アドバンス" : "ノーマル")
                }
            }
        }
    }
}

#Preview {
    StatsView(game: GameItem(date: Date(), team1Name: "チーム1", team2Name: "チーム2"))
}
