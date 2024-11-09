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
    
    var teamList: [String]{
        [game.team1.teamName, game.team2.teamName]
    }
    
    // 選択されたアクション名
    @State private var selectedAction: String = ""
    
    var body: some View {
        NavigationStack {
            // Pickerでアクションを選択
            ActionPicker(selectedAction: $selectedAction, timeline: game.timeline)
            ScrollView(.vertical) {
                VStack{
                    
                    // チームごとに表示
                    HStack(alignment: .top){
                        ForEach(teamList, id:\.self){teamName in
                            let timelineItems = groupedByActor[teamName] ?? []
                            let chartData = timelineItems.filter { $0.actionName == selectedAction }
                            LabelCountPieChart(actor: game.team1.teamName, chartData: chartData)
                        }
                    }
                    
                    // 選手のグラフ
                    ForEach(groupedByActor.keys.sorted().filter { !isTeamName($0)}, id: \.self) { player in
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
    
    private func isTeamName(_ name: String) -> Bool {
        name == game.team1.teamName || name == game.team2.teamName
    }
}

#Preview {
    AdvancedStatsGraphView(game: .constant(GameItem(date: Date(), team1Name: "チーム1", team2Name: "チーム2")))
}
