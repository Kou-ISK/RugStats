//
//  PossessionPieChart.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/22.
//

import SwiftUI
import Charts

// TODO: DurationPieChartという名前に変更して汎用化する
struct PossessionPieChart: View {
    var timeline: [TimelineItem]
    
    // "Possession"アクションを持つタイムライン項目のみをフィルタリング
    var filteredTimeline: [TimelineItem] {
        return timeline.filter { $0.actionName == "Possession" }
    }
    
    // チームごとの所持時間を計算
    var possessionDurations: [String: TimeInterval] {
        var durations: [String: TimeInterval] = [:]
        
        for item in filteredTimeline {
            let duration = (item.endGameClock ?? item.startGameClock) - item.startGameClock
            durations[item.actorName, default: 0] += duration
        }
        
        return durations
    }
    
    // 全体の所持時間を計算
    var totalDurations: TimeInterval {
        return possessionDurations.values.reduce(0, +)
    }
    
    var body: some View {
        VStack {
            Text("Possession by Team")
                .font(.headline)
            
            Chart {
                // possessionDurationsのキーをArrayに変換してForEachに渡す
                ForEach(possessionDurations.sorted(by: { $0.key < $1.key }), id: \.key) { team, duration in
                    
                    // パーセンテージの計算
                    let percentage = totalDurations > 0 ? (duration / totalDurations) * 100 : 0
                    // 円グラフの各セグメントを追加
                    SectorMark(
                        angle: .value("Possession Duration", duration as Double),
                        innerRadius: .ratio(0.5)
                        // series: .value("Team", team)
                    )
                    .foregroundStyle(by: .value("Team", team))
                    .annotation(position: .overlay) {
                        Text("\(String(format: "%.0f", percentage))%")
                            .bold()
                            .font(.headline) // %のフォントサイズを大きくする
                    }
                }
            }
            .chartLegend(.visible)
            .chartLegend(position: .bottom)  // chartLegendPositionのエラーを修正
        }
    }
}

#Preview {
    PossessionPieChart(timeline: [
        TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), endGameClock: TimeInterval(150), actorName: "チーム1", actionName: "Possession"),
        TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(160), endGameClock: TimeInterval(180), actorName: "チーム2", actionName: "Possession")
    ])
}
