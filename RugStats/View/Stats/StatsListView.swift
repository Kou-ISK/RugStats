//
//  StatsListView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI
import SwiftData

struct StatsListView: View {
    @Environment(\.modelContext) private var modelContext
    var gameList: [GameItem]
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("ゲーム一覧")
                List {
                    ForEach(gameList) { game in
                        NavigationLink(destination: StatsView(game: game)) {
                            VStack(alignment: .leading) {
                                ScoreView(game: game)
                                Text("@\(game.fieldName)")
                                Text("備考: \(game.basicInfo)")
                            }
                        }
                    }
                    .onDelete(perform: deleteGame)
                }
            }
        }.navigationTitle("チームプリセット一覧")
    }
    
    private func deleteGame(offsets: IndexSet) {
        // offsetsから削除するアイテムを取得
        offsets.map { gameList[$0] }.forEach { game in
            // modelContextからゲームを削除
            modelContext.delete(game)
        }
        do {
            // モデルコンテキストの保存
            try modelContext.save()
        } catch {
            print("削除エラー: \(error.localizedDescription)")
        }
    }
}

#Preview {
    StatsListView(gameList: [GameItem(date: Date(), team1Name: "チーム1", team2Name: "チーム2")])
}
