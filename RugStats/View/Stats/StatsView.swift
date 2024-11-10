//
//  StatsView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI

struct StatsView: View {
    @State var game: GameItem
    
    @State private var isNormalMode: Bool = true
    
    @State private var sharedFileURL: URL? // JSONファイルの一時URLを保持
    
    var body: some View {
        VStack {
            // スコア表示
            ScoreView(game: game)
            
            if(isNormalMode){
                NormalStatsTableView(timeline: $game.timeline)
            }else{
                AdvancedStatsView(game: $game)
            }
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    isNormalMode.toggle()
                }){
                    Text(isNormalMode ? "アドバンス" : "ノーマル")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                if let fileURL = sharedFileURL {
                    ShareLink(item: fileURL, preview: SharePreview("\(game.team1.teamName) v \(game.team2.teamName)", image: Image(systemName: "doc")))
                } else {
                    ProgressView() // URLが生成されるまでインジケータを表示
                }
            }
        }.onAppear {
            createJSONFile()
        }
    }
    
    private func createJSONFile() {
            // JSON形式に変換
            guard let jsonData = game.toJSON()?.data(using: .utf8) else {
                print("Failed to convert GameItem to JSON data.")
                return
            }
            
            // 一時ディレクトリにファイルを作成
            let tempDirectory = FileManager.default.temporaryDirectory
        let fileURL = tempDirectory.appendingPathComponent("\(game.team1.teamName) v \(game.team2.teamName).json")
            
            do {
                // JSONデータをファイルに書き込む
                try jsonData.write(to: fileURL)
                sharedFileURL = fileURL // 共有リンクのURLを設定
            } catch {
                print("Failed to write JSON data to file:", error)
            }
        }
}

#Preview {
    StatsView(game: GameItem(date: Date(), team1Name: "チーム1", team2Name: "チーム2"))
}
