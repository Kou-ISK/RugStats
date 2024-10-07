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
            ScoreView(game: $game)
            // 仮で表を表示
            HStack{
                countActions(team1Name: game.team1Name, team2Name: game.team2Name)
            }
            NormalStatsTableView(timeline: $game.timeline)
        }
        // タブで表示を切り替える
        // 1. 一般的なスタッツを表形式で表示
        // 2. スコアシートの形式で表示
        // 3. スタッツをグラフ表示
        // 4. 専門的なスタッツを表示(フィルターあり、座標あり)
        
        // 計算用のロジックはVMに切り出す
    }
    
    // TODO 別のViewに切り出す(仮実装)
    private func countActions(team1Name: String, team2Name: String)-> some View{
        let actions = game.timeline
        return VStack{
            ForEach(actionList, id:\.self){action in
                HStack{
                    Text(String(actions.count(where: {$0.actionName == action && $0.actorName == team1Name})))
                    Text(action)
                    Text(String(actions.count(where: {$0.actionName == action && $0.actorName == team2Name})))
                }
            }
        }
    }
}

#Preview {
    StatsView(game: GameItem(timestamp: Date(), team1Name: "チーム1", team2Name: "チーム2"))
}
