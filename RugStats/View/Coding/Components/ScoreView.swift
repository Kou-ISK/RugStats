//
//  ScoreView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/06.
//

import SwiftUI

struct ScoreView: View {
    @Binding var game: GameItem
    
    // チームごとのアクションを集計してスコアを計算する関数
    private func calculateScore(for teamName: String) -> Int {
        let actions = game.timeline.filter { $0.actorName == teamName }
        
        // 各アクションとその対応する得点
        let scoreMapping: [(action: String, label: String?, points: Int)] = [
            ("トライ", nil, 5),
            ("コンバージョンG", "成功", 2),
            ("PG", "成功", 3),
            ("DG", "成功", 3)
        ]
        
        return scoreMapping.reduce(0) { total, scoreItem in
            total + actions.count(where: { action in
                action.actionName == NSLocalizedString(scoreItem.action, comment: "") &&
                (scoreItem.label == nil || action.actionLabels.contains { $0.label == NSLocalizedString(scoreItem.label!, comment: "") })
            }) * scoreItem.points
        }
    }
    
    var body: some View {
        HStack {
            Text(game.team1.teamName).font(.title3)
            Text("\(String(calculateScore(for: game.team1.teamName))) - \(String(calculateScore(for: game.team2.teamName)))").font(.title).bold()
            Text(game.team2.teamName).font(.title3)
        }
    }
}

#Preview {
    ScoreView(game: .constant(GameItem(date: Date(), team1Name: "チーム1", team2Name: "チーム2", fieldName: "XXスタジアム", basicInfo: "公式戦")))
}
