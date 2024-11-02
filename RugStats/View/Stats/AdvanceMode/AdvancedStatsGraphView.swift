//
//  AdvancedStatsGraphView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/18.
//

import SwiftUI
import Charts

struct AdvancedStatsGraphView: View {
    @Binding var timeline: [TimelineItem]
    
    // アクション名のリスト
    var actionNames: [String] {
        Array(Set(timeline.map { $0.actionName })).sorted()
    }
    
    // アクターごとの [TimelineItem] をグループ化
    var groupedByActor: [String: [TimelineItem]] {
        Dictionary(grouping: timeline, by: { $0.actorName })
    }
    
    // 選択されたアクション名
    @State private var selectedAction: String = ""
    
    var body: some View {
        NavigationStack {
            // Pickerでアクションを選択
            Picker("アクションを選択", selection: $selectedAction) {
                ForEach(actionNames, id: \.self) { action in
                    Text(action)
                }
            }
            .pickerStyle(SegmentedPickerStyle()) // セグメント形式のPickerスタイル
            .padding()
            // TODO: グラフをコンポーネントに切り出し、整理する
            ScrollView(.vertical) {
                VStack{
                    // アクター名ごとにループして表示
                    HStack(alignment: .top){
                        ForEach(groupedByActor.keys.sorted(), id: \.self) { actor in
                            let actorTimelineItems = groupedByActor[actor] ?? []
                            let chartData = actorTimelineItems.filter { $0.actionName == selectedAction }
                            
                            VStack{
                                Text(actor)
                                LabelCountPieChart(actor: actor, chartData: chartData)
                            }
                        }
                        if(selectedAction == "Possession"){
                            PossessionPieChart(timeline: timeline)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AdvancedStatsGraphView(timeline: .constant([
        TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), actorName: "チーム1", actionName: "タックル", actionLabels: [
            ActionLabelItem(label: "成功", category: ActionLabelCategory(categoryName: "カテゴリ")),
            ActionLabelItem(label: "失敗", category: ActionLabelCategory(categoryName: "カテゴリ"))
        ]),
        TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(200), actorName: "チーム2", actionName: "キック", actionLabels: [
            ActionLabelItem(label: "成功", category: ActionLabelCategory(categoryName: "カテゴリ"))
        ]),
        TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(210), actorName: "チーム1", actionName: "タックル", actionLabels: [
            ActionLabelItem(label: "失敗",  category: ActionLabelCategory(categoryName: "カテゴリ"))
        ]),
        TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(300), actorName: "チーム1", actionName: "タックル", actionLabels: [
            ActionLabelItem(label: "成功",  category: ActionLabelCategory(categoryName: "カテゴリ")),
            ActionLabelItem(label: "失敗",  category: ActionLabelCategory(categoryName: "カテゴリ")) // TODO: 相反するラベルを設定できないように対応するか検討
        ])
    ]))
}
