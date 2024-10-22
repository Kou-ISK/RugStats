//
//  LabelCountPieChart.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/22.
//

import SwiftUI
import Charts

struct LabelCountPieChart: View {
    var actor: String
    var chartData: [TimelineItem]
    
    var body: some View {
        // カテゴリごとにラベルの内訳を集計
        let labelsByCategory = chartData
            .flatMap { $0.actionLabels }
            .reduce(into: [String: [String: Int]]()) { counts, labelItem in
                counts[labelItem.category.categoryName, default: [:]][labelItem.label, default: 0] += 1
            }
        
        VStack(spacing: 20) {
            ForEach(labelsByCategory.keys.sorted(), id: \.self) { category in
                VStack {
                    Text(category) // カテゴリ名を表示
                        .font(.headline)
                    
                    // カテゴリごとのラベル内訳円グラフ
                    let labelCounts = labelsByCategory[category] ?? [:]
                    let totalLabelsInCategory = labelCounts.values.reduce(0, +)
                    
                    if totalLabelsInCategory > 0 {
                        Chart {
                            ForEach(labelCounts.keys.sorted(), id: \.self) { label in
                                SectorMark(
                                    angle: .value("Count", labelCounts[label] ?? 0),
                                    innerRadius: .inset(30)
                                )
                                .foregroundStyle(by: .value("Label", label))
                            }
                        }
                        .frame(width: 200, height: 200)
                    } else {
                        Text("データがありません")
                    }
                }
            }
        }
    }
}

#Preview {
    LabelCountPieChart(
        actor: "チーム1",
        chartData: [
            TimelineItem(
                startTimestamp: Date(),
                startGameClock: TimeInterval(100),
                actorName: "チーム1",
                actionName: "タックル",
                actionLabels: [
                    ActionLabelItem(label: "成功", category: ActionLabelCategory(categoryName: "攻撃")),
                    ActionLabelItem(label: "失敗", category: ActionLabelCategory(categoryName: "防御"))
                ]
            ),
            TimelineItem(
                startTimestamp: Date(),
                startGameClock: TimeInterval(200),
                actorName: "チーム1",
                actionName: "タックル",
                actionLabels: [
                    ActionLabelItem(label: "成功", category: ActionLabelCategory(categoryName: "攻撃")),
                    ActionLabelItem(label: "失敗", category: ActionLabelCategory(categoryName: "攻撃"))
                ]
            )
        ]
    )
}
