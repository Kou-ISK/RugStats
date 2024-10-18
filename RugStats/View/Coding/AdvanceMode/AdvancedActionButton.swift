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
    
    var actorInfo: GameTeamInfo
    var action: ActionLabelPresetItem
    
    var body: some View {
        Button(action.actionName){
            isClicked.toggle()
            
            // 初回クリック時
            if(isClicked){
                currentAction.actorName = actorInfo.teamName
                currentAction.actionName = action.actionName
                // 時間を記録
                currentAction.startTimestamp = Date()
                currentAction.startGameClock = gameClock
                
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
            .tint(!isClicked ? Color(CGColor(red: actorInfo.teamColor?.red ?? 0, green: actorInfo.teamColor?.green ?? 0, blue: actorInfo.teamColor?.blue ?? 0, alpha: actorInfo.teamColor?.alpha ?? 100)) : .gray)
            .sheet(isPresented: $showFieldPositionView){
                AdvancedFieldPositionView(action: $currentAction, isStartLocation: isClicked)
            }
            .sheet(isPresented: $showLabelView){
                AdvancedLabelView(action: $currentAction, labelSet: action.labelSet)
            }
    }
}

#Preview {
    AdvancedActionButton(gameClock: .constant(TimeInterval(100)), timeline: .constant([TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), actorName: "チーム1", actionName: "タックル")]), actorInfo: GameTeamInfo(teamName: "チーム1"), action: ActionLabelPresetItem(actionName: "タックル", labelSet: [ActionLabelCategory(categoryName: "成否")]))
}
