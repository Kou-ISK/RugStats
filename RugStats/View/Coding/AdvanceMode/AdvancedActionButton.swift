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
    @State private var showLabelView: Bool = false
    
    @State private var currentAction: TimelineItem = TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(), actorName: "", actionName: "")
    
    var actorName: String
    var action: ActionLabelPresetItem
    
    var body: some View {
        Button(action.actionName){
            // 初回クリック時
            if(!isClicked){
                isClicked.toggle()
                currentAction.startTimestamp = Date()
                currentAction.startGameClock = gameClock
                currentAction.actorName = actorName
                currentAction.actionName = action.actionName
                // TODO: フィールドポジション選択画面を表示
                
                showLabelView = true
            }else{
                isClicked.toggle()
                // TODO: フィールドポジション選択画面を表示
                // TODO: SwiftDataに保存
                
                showLabelView = true
            }
        }.buttonStyle(.borderedProminent).tint(isClicked ? .gray : .orange) // TODO: 正常時はチームカラーを利用するようにする
        .sheet(isPresented: $showLabelView){
            // TODO: onClickでsheet表示
            AdvancedLabelView(labelSet: action.labelSet)
        }
    }
}

#Preview {
    AdvancedActionButton(gameClock: .constant(TimeInterval(100)), timeline: .constant([TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), actorName: "チーム1", actionName: "タックル")]), actorName: "チーム1", action: ActionLabelPresetItem(actionName: "タックル", labelSet: [ActionLabelCategory(categoryName: "成否")]))
}
