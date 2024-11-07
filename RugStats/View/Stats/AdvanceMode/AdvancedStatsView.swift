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
        case field
        
        // ローカライズされた表示名を提供するプロパティ
        var displayName: String {
            switch self {
            case .table:
                return NSLocalizedString("Table", comment: "Table View")
            case .graph:
                return NSLocalizedString("Chart", comment: "Chart View")
            case .field:
                return NSLocalizedString("Field", comment: "Field Position View")
            }
        }
    }
    
    @Binding var game: GameItem
    @State private var currentMode: Mode = .table // 現在のモードを保持
    
    var body: some View {
        VStack{
            // 選択されたモードに応じて表示を切り替える
            switch currentMode {
                case .table:
                    // アドバンスモードで表示されるビュー
                    AdvancedStatsTableView(timeline: $game.timeline)
                    
                case .graph:
                    // グラフモードで表示されるビュー
                    // TODO: 個人スタッツを表示する機能を追加
                    AdvancedStatsGraphView(game: $game)
                case .field:
                    AdvancedStatsFieldPositionView(timeline: $game.timeline)
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
    AdvancedStatsView(game: .constant(GameItem(date: Date(), team1Name: "チーム1", team2Name: "チーム2")))
}
