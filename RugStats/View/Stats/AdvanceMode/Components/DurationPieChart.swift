//
//  DurationPieChart.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/22.
//

import SwiftUI
import Charts

struct DurationPieChart: View {
    var timeline: [TimelineItem]
    var actionName: String
    
    // 渡されたアクション名を持つタイムライン項目のみをフィルタリング
    var filteredTimeline: [TimelineItem] {
        return timeline.filter { $0.actionName == actionName }
    }
    
    // チームごとの所持時間を計算
    var actionDurationsForTeam: [String: TimeInterval] {
        var durations: [String: TimeInterval] = [:]
        
        for item in filteredTimeline {
            let duration = (item.endGameClock ?? item.startGameClock) - item.startGameClock
            durations[item.actorName, default: 0] += duration
        }
        
        return durations
    }
    
    // 全体の所持時間を計算
    var totalDurations: TimeInterval {
        return actionDurationsForTeam.values.reduce(0, +)
    }
    
    var body: some View {
        VStack {
            Text("\(actionName) by Team")
                .font(.headline)
            
            Chart {
                // possessionDurationsのキーをArrayに変換してForEachに渡す
                ForEach(actionDurationsForTeam.sorted(by: { $0.key < $1.key }), id: \.key) { team, duration in
                    
                    // パーセンテージの計算
                    let percentage = totalDurations > 0 ? (duration / totalDurations) * 100 : 0
                    // 円グラフの各セグメントを追加
                    SectorMark(
                        angle: .value("\(actionName) Duration", duration as Double),
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
    DurationPieChart(timeline: [
        TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), endGameClock: TimeInterval(150), actorName: "チーム1", actionName: "Possession"),
        TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(160), endGameClock: TimeInterval(180), actorName: "チーム2", actionName: "Possession")
    ], actionName: "Possession")
}
