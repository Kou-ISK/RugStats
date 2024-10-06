//
//  NormalStatsTableRow.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/06.
//

import SwiftUI

struct NormalStatsTableRow: View {
    @State var item: TimelineItem
    var body: some View {
        HStack {
            Text(item.actorName)
                .frame(width: 100, alignment: .leading)
            Text(item.actionName)
                .frame(width: 100, alignment: .leading)
            Text(item.actionLabels.joined(separator: "、"))
                .frame(width: 100, alignment: .leading)
            Text(formatTimeInterval(item.gameClock))
                .frame(width: 50, alignment: .leading)
            Text(dateFormatter.string(from: item.timestamp))
                .frame(width: 100, alignment: .leading)
        }
    }
    
    // DateFormatter はプロパティの初期化内で設定する
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter
    }()
    
    // ゲームクロックをフォーマットする関数
    private func formatTimeInterval(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    NormalStatsTableRow(item: TimelineItem(timestamp: Date(), gameClock: TimeInterval(300), actorName: "チーム1", actionName: "トライ"))
}
