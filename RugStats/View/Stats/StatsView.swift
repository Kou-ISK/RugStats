//
//  StatsView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI

struct StatsView: View {
    @State var game: GameItem
    
    // モードを定義
    enum Mode: String, CaseIterable {
        case normal = "ノーマル"
        case advanced = "アドバンス"
        case individual = "個人"
        case graph = "グラフ"
    }
    
    @State var currentMode: Mode = .normal // 現在のモードを保持
    
    var body: some View {
        VStack {
            // スコア表示
            ScoreView(game: $game)
            
            // 選択されたモードに応じて表示を切り替える
            switch currentMode {
            case .normal:
                // ノーマルモードで表示されるビュー
                NormalActionCountView(game: $game)
                NormalStatsTableView(timeline: $game.timeline)
                
            case .advanced:
                // アドバンスモードで表示されるビュー
                    AdvancedStatsTableView(timeline: $game.timeline)
                
            case .individual:
                // TODO: 個人モードで表示されるビュー
                Text("個人モード")
                // TODO: 他の個人モード用のビューを追加
                
            case .graph:
                // グラフモードで表示されるビュー
                Text("グラフモード")
                // グラフ表示用のビューを追加
            }
        }
        .toolbar {
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
    StatsView(game: GameItem(date: Date(), team1Name: "チーム1", team2Name: "チーム2"))
}
