//
//  ScoreView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/06.
//

import SwiftUI

struct ScoreView: View {
    @Binding var game: GameItem
    
    private func calculateScore(teamName: String)->Int{
        let actions = game.timeline.filter({$0.actorName == teamName})
        let tries = actions.count(where: {$0.actionName == NSLocalizedString("トライ", comment: "Action: Try")})
        let conversions = actions.count(where: {
            $0.actionName == NSLocalizedString("コンバージョンG", comment: "Action: Conversion") && $0.actionLabels.contains(NSLocalizedString("成功", comment: "キック: 成功"))
        })
        let penaltyGoals = actions.count(where: {
            $0.actionName == NSLocalizedString("PG", comment: "Action: PG") && $0.actionLabels.contains(NSLocalizedString("成功", comment: "キック: 成功"))
        })
        let dropGoals = actions.count(where: {
            $0.actionName == NSLocalizedString("DG", comment: "Action: DG") && $0.actionLabels.contains(NSLocalizedString("成功", comment: "キック: 成功"))
        })
        return tries * 5 + conversions * 2 + penaltyGoals * 3 + dropGoals * 3
    }
    
    var body: some View {
        VStack {
            Text("\(String(calculateScore(teamName: game.team1Name))) - \(String(calculateScore(teamName: game.team2Name)))").font(.title).bold()
            HStack{
                Text(game.team1Name).font(.title3)
                Text(game.team2Name).font(.title3)
            }
            Divider()
        }
    }
}

#Preview {
    CodingView(game: .constant(GameItem(timestamp: Date(), team1Name: "チーム1", team2Name: "チーム2", fieldName: "XXスタジアム", basicInfo: "公式戦")))
}
