//
//  AdvancedStatsView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/18.
//

import SwiftUI

struct AdvancedStatsView: View {
    // モードを定義
    enum Mode: String, CaseIterable {
        case table = "表"
        case individual = "個人"
        case graph = "グラフ"
    }
    
    @Binding var timeline: [TimelineItem]
    @State private var currentMode: Mode = .table // 現在のモードを保持
    
    var body: some View {
        VStack{
            // 選択されたモードに応じて表示を切り替える
            switch currentMode {
                case .table:
                    // アドバンスモードで表示されるビュー
                    AdvancedStatsTableView(timeline: $timeline)
                    
                case .individual:
                    // TODO: 個人モードで表示されるビュー
                    Text("個人モード")
                    // TODO: 他の個人モード用のビューを追加
                    
                case .graph:
                    // グラフモードで表示されるビュー
                    AdvancedStatsGraphView(timeline: $timeline)
            }
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // Pickerを使ってモードを切り替える
                Picker("表示モード", selection: $currentMode) {
                    ForEach(Mode.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(SegmentedPickerStyle()) // セグメントスタイルのPickerを使用
            }
        }
    }
}

#Preview {
    AdvancedStatsView(timeline: .constant([TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), actorName: "チーム1", actionName: "タックル")]))
}
