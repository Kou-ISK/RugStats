//
//  AdvancedActionButton.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/14.
//

import SwiftUI

struct AdvancedActionButton: View {
    @Binding var gameClock: TimeInterval // ストップウォッチの経過時間
    @Binding var timeline: [TimelineItem]
    
    @State private var isClicked: Bool = false
    
    @State private var currentAction: TimelineItem = TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(), actorName: "", actionName: "")
    
    var actorName: String
    var actionName: String
    
    var body: some View {
        Button("アクション名"){
            // 初回クリック時
            if(!isClicked){
                isClicked.toggle()
                currentAction.startTimestamp = Date()
                currentAction.startGameClock = gameClock
                currentAction.actorName = actorName
                currentAction.actionName = actionName
                // TODO: ラベル追加タイミングを検討
                // TODO: フィールドポジション選択画面を表示
            }else{
                // TODO: ラベル追加タイミングを検討
                // TODO: フィールドポジション選択画面を表示
                // TODO: SwiftDataに保存
            }
        }
    }
}

#Preview {
    AdvancedActionButton(gameClock: .constant(TimeInterval(100)), timeline: .constant([TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), actorName: "チーム1", actionName: "タックル")]), actorName: "チーム1", actionName: "タックル")
}
