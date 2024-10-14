//
//  NormalActionButton.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/03.
//

import SwiftUI

struct NormalActionButton: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var timeline: [TimelineItem]
    @State private var isLabelViewPresented: Bool = false
    var teamName: String
    var actionName: String
    var gameClock: TimeInterval
    
    @State private var currentAction: TimelineItem? = nil
    
    var body: some View {
        // アクションの数を表示
        let count = timeline.count(where: { $0.actorName == teamName && $0.actionName == actionName })
        
        Button("\(actionName): \(count)") {
            // 新規アクションを作成
            currentAction = TimelineItem(
                startTimestamp: Date(),
                startGameClock: gameClock,
                actorName: teamName,
                actionName: actionName
            )
            
            // タイムラインに追加
            if let action = currentAction {
                timeline.append(action)
                modelContext.insert(action)
                // ラベルビューを表示する
                isLabelViewPresented = true
            }
        }
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $isLabelViewPresented) {
            // currentActionを直接渡す
            if let action = currentAction {
                NormalLabelView(
                    targetAction: Binding<TimelineItem>(
                        get: { action },
                        set: { currentAction = $0 }
                    )
                )
            }
        }
    }
}



#Preview {
    NormalActionButton(timeline: .constant([]), teamName: "チーム1", actionName: "トライ", gameClock: TimeInterval(100))
}
