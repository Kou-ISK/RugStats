//
//  AdvancedStatsView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/18.
//

import SwiftUI

struct AdvancedStatsView: View {
    // モードを定義
    enum Mode: CaseIterable {
        case table
        case graph
        
        // ローカライズされた表示名を提供するプロパティ
        var displayName: String {
            switch self {
            case .table:
                return NSLocalizedString("Table", comment: "Table View")
            case .graph:
                return NSLocalizedString("Chart", comment: "Chart View")
            }
        }
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
                    
                case .graph:
                    // グラフモードで表示されるビュー
                    // TODO: 個人スタッツを表示する機能を追加
                    AdvancedStatsGraphView(timeline: $timeline)
            }
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // Pickerを使ってモードを切り替える
                Picker("表示モード", selection: $currentMode) {
                    ForEach(Mode.allCases, id: \.self) { mode in
                        Text(mode.displayName).tag(mode)
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
