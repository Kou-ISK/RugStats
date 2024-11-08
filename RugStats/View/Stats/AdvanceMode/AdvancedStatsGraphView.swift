//
//  AdvancedStatsGraphView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/18.
//

import SwiftUI
import Charts

struct AdvancedStatsGraphView: View {
    @Binding var game: GameItem
    
    // アクターごとの [TimelineItem] をグループ化
    var groupedByActor: [String: [TimelineItem]] {
        Dictionary(grouping: game.timeline, by: { $0.actorName })
    }
    
    // 選択されたアクション名
    @State private var selectedAction: String = ""
    
    var body: some View {
        NavigationStack {
            // Pickerでアクションを選択
            ActionPicker(selectedAction: $selectedAction, timeline: game.timeline)
            // TODO: グラフをコンポーネントに切り出し、整理する
            ScrollView(.vertical) {
                VStack{
                    
                    // チームごとに表示
                    HStack(alignment: .top){
                        // TODO: チームごとのグラフ作成をシンプルな実装にリファクタする
                        VStack{
                            let team1TimelineItems = groupedByActor[game.team1.teamName] ?? []
                            let team1chartData = team1TimelineItems.filter { $0.actionName == selectedAction }
                            LabelCountPieChart(actor: game.team1.teamName, chartData: team1chartData)
                        }
                        VStack{
                            let team2TimelineItems = groupedByActor[game.team2.teamName] ?? []
                            let team2chartData = team2TimelineItems.filter { $0.actionName == selectedAction }
                            LabelCountPieChart(actor: game.team2.teamName, chartData: team2chartData)
                        }
                        
                    }
                    
                    // 選手のグラフ
                    ForEach(groupedByActor.keys.sorted().filter { $0 != game.team1.teamName && $0 != game.team2.teamName}, id: \.self) { player in
                        if let playerData = groupedByActor[player] {
                            VStack {
                                LabelCountPieChart(actor: player, chartData: playerData)
                            }
                        }
                    }
                    // 指定したアクションのチーム別合計時間を円グラフとして表示する
                    if(selectedAction == "Possession"){
                        DurationPieChart(timeline: game.timeline, actionName: selectedAction)
                    }
                }
            }
        }
    }
}

#Preview {
    AdvancedStatsGraphView(game: .constant(GameItem(date: Date(), team1Name: "チーム1", team2Name: "チーム2")))
}
