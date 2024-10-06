//
//  NormalStatsTableView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/03.
//

import SwiftUI

struct NormalStatsTableView: View {
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
    
    @Binding var timeline: [TimelineItem]
    
    var body: some View {
        VStack(alignment: .leading) {
            // ヘッダー部分を作成
            ScrollView([.horizontal]) {
                HStack {
                    Text("チーム")
                        .bold()
                        .frame(width: 100, alignment: .leading)
                    Text("アクション")
                        .bold()
                        .frame(width: 100, alignment: .leading)
                    Text("ラベル")
                        .bold()
                        .frame(width: 100, alignment: .leading)
                    Text("ゲームクロック")
                        .bold()
                        .frame(width: 50, alignment: .leading)
                    Text("タイムスタンプ")
                        .bold()
                        .frame(width: 100, alignment: .leading)
                }.padding(.bottom, 5)
                
                Divider()
                ScrollView([.vertical]) {
                    VStack(alignment: .leading){
                        // データ部分を作成
                        ForEach(timeline) { item in
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
                            Divider()
                        }
                    }
                }
            }
        }.padding()
    }
}

#Preview {
    NormalStatsTableView(timeline: .constant([]))
}
