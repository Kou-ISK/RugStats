//
//  AdvancedActionButton.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/14.
//

import SwiftUI

struct AdvancedActionButton: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var gameClock: TimeInterval // ストップウォッチの経過時間
    @Binding var timeline: [TimelineItem]
    
    @State private var isClicked: Bool = false
    @State private var showLabelView: Bool = false
    @State private var showFieldPositionView: Bool = false
    
    @State private var currentAction: TimelineItem = TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(), actorName: "", actionName: "")
    
    var actorName: String
    var actorColor: ColorItem?
    var action: ActionLabelPresetItem
    
    var body: some View {
        Button(action.actionName){
            isClicked.toggle()
            
            // 初回クリック時
            if(isClicked){
                // 新規TimelineItemを作成
                currentAction = TimelineItem(startTimestamp: Date(), startGameClock: gameClock, actorName: actorName, actionName: action.actionName)
                
                // SwiftDataに追加
                modelContext.insert(currentAction)
                
                // シート表示用のフラグをOnにする
                showFieldPositionView = true
                showLabelView = true
            }else{
                // 時間を記録
                currentAction.endTimeSstamp = Date()
                currentAction.endGameClock = gameClock
                
                timeline.append(currentAction)
                // SwiftDataの対象を保存
                do{
                    try modelContext.save()
                }catch{
                    print(error.localizedDescription)
                }
                // シート表示用のフラグをOnにする
                showFieldPositionView = true
                showLabelView = true
            }
        }.buttonStyle(.borderedProminent)
            .tint(!isClicked ? Color(CGColor(red: actorColor?.red ?? 0, green: actorColor?.green ?? 0, blue: actorColor?.blue ?? 0, alpha: actorColor?.alpha ?? 100)) : .gray)
            .fullScreenCover(isPresented: $showFieldPositionView){
                AdvancedFieldPositionView(action: $currentAction, isStartLocation: isClicked)
            }
            .fullScreenCover(isPresented: $showLabelView){
                AdvancedLabelView(action: $currentAction, labelSet: action.labelSet)
            }
    }
}

#Preview {
    AdvancedActionButton(gameClock: .constant(TimeInterval(100)), timeline: .constant([TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), actorName: "チーム1", actionName: "タックル")]), actorName: "チーム1",actorColor: ColorItem(red: 0, green: 0, blue: 0, alpha: 0),action: ActionLabelPresetItem(actionName: "タックル", labelSet: [ActionLabelCategory(categoryName: "成否")]))
}
