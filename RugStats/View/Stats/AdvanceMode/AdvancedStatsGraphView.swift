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
    
    // アクターごとにグループ化したタイムラインを返す
    var groupedTimeline: [String: [TimelineItem]] {
        Dictionary(grouping: timeline, by: { $0.actorName })
    }
    
    // 選択されたアクション名
    @State private var selectedAction: String = ""
    
    var body: some View {
        NavigationStack{
            VStack {
                // 選択されたアクションに基づいてグラフを表示
                if !selectedAction.isEmpty {
                    VStack {
                        ForEach(groupedTimeline.keys.sorted(), id: \.self) { actor in
                            let actorTimeline = groupedTimeline[actor] ?? []
                            let filteredTimeline = actorTimeline.filter { $0.actionName == selectedAction }
                            
                            if !filteredTimeline.isEmpty {
                                VStack {
                                    Text(actor) // 各アクター名を表示
                                        .font(.headline)
                                    
                                    // アクターごとの円グラフ
                                    // TODO: カテゴリごとにグラフを作成出来るようにモデル修正するか検討
                                    Chart(filteredTimeline, id: \.id) { item in
                                        ForEach(item.actionLabels, id: \.id) { labelItem in
                                            SectorMark(
                                                angle: .value("Count", 1), // 各ラベルごとのセクター
                                                innerRadius: .inset(30)
                                            )
                                            .foregroundStyle(by: .value("Label", labelItem.label))
                                        }
                                    }
                                    .frame(width: 300, height: 300)
                                }
                                .padding(.bottom, 20) // 各円グラフの間に余白を追加
                            }
                        }
                    }
                } else {
                    Text("アクションを選択してください")
                        .foregroundColor(.gray)
                }
            }.toolbar{
                ToolbarItem(placement: .automatic){
                    // Pickerでアクションを選択
                    Picker("アクションを選択", selection: $selectedAction) {
                        ForEach(actionNames, id: \.self) { action in
                            Text(action)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle()) // セグメント形式のPickerスタイル
                    .padding()
                }
            }
        }
    }
}

#Preview {
    AdvancedStatsGraphView(timeline: .constant([
        TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), actorName: "チーム1", actionName: "タックル", actionLabels: [
            ActionLabelItem(label: "成功"),
            ActionLabelItem(label: "失敗")
        ]),
        TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(200), actorName: "チーム2", actionName: "キック", actionLabels: [
            ActionLabelItem(label: "成功")
        ]),
        TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(210), actorName: "チーム1", actionName: "タックル", actionLabels: [
            ActionLabelItem(label: "失敗")
        ]),
        TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(300), actorName: "チーム1", actionName: "タックル", actionLabels: [
            ActionLabelItem(label: "成功"),
            ActionLabelItem(label: "失敗") // TODO: 相反するラベルを設定できないように対応するか検討
        ])
    ]))
}
