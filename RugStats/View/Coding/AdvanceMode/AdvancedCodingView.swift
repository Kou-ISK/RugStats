//
//  AdvancedCodingView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/12.
//

import SwiftUI

struct AdvancedCodingView: View {
    @Binding var gameInfo: GameItem
    @Binding var gameClock: TimeInterval // ストップウォッチの経過時間
    var actionPresetList: [ActionPresetItem]
    
    var body: some View {
        // TODO: 実装
        Text("Hello, World!")
    }
}

#Preview {
    AdvancedCodingView(gameInfo: .constant(GameItem(date: Date(), team1Name: "チーム1", team2Name: "チーム2")), gameClock: .constant(TimeInterval(100)), actionPresetList: [ActionPresetItem(presetName: "プリセット", actions: [ActionLabelPresetItem(actionName: "アクション", labelSet: [ActionLabelItem(label: "ラベル")])])])
}
