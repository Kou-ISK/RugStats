//
//  StatsView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI

struct StatsView: View {
    @State var game: GameItem
    var body: some View {
        VStack{
            Text("\(game.team1Name) vs. \(game.team2Name)")
            // 仮で表を表示
            NormalStatsView(timeline: $game.timeline)
        }
        // タブで表示を切り替える
        // 1. 一般的なスタッツを表形式で表示
        // 2. スコアシートの形式で表示
        // 3. スタッツをグラフ表示
        // 4. 専門的なスタッツを表示(フィルターあり、座標あり)
        
        // 計算用のロジックはVMに切り出す
    }
}

#Preview {
    StatsView(game: GameItem(timestamp: Date(), team1Name: "チーム1", team2Name: "チーム2"))
}
