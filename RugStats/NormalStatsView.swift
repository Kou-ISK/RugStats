//
//  NormalStatsView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/03.
//

import SwiftUI

struct NormalStatsView: View {
    @State var timeline: [TimelineItem]
    var body: some View {
        // ここにスタッツを表示
        Text("スタッツ")
        Table(timeline){
            TableColumn("チーム"){item in
                Text(item.actorName)
            }
            TableColumn("アクション"){item in
                Text(item.actionName)
            }
            TableColumn("タイムスタンプ"){item in
                // TODO 表示形式を考える
                // Text(item.timestamp.seconds)
            }
            TableColumn("ゲームタイム"){item in
                // TODO 表示形式を考える
                // Text(item.gameTime)
            }
        }
    }
}

#Preview {
    NormalStatsView(timeline: [TimelineItem(timestamp: Date(), gameTime: TimeInterval(100), actorName: "チーム1", actionName: "トライ")])
}
