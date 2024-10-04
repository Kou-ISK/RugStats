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
    @State private var isPushed: Bool = false
    var teamName: String
    var actionName: String
    var gameTime: TimeInterval
    
    @State private var currentAction: TimelineItem? = nil
    
    var body: some View {
        // アクションの数を表示
        let count = timeline.count(where: { $0.actorName == teamName && $0.actionName == actionName })
        
        Button("\(teamName) \(actionName): \(count)") {
            // 新規アクションを作成
            currentAction = TimelineItem(timestamp: Date(), gameTime: gameTime, actorName: teamName, actionName: actionName)
            // タイムラインに追加
            if let action = currentAction {
                timeline.append(action)
                
                // TODO modelContextに保存されるように修正
                do {
                    // SwiftDataのコンテキストに保存
                    try modelContext.save()
                } catch {
                    print("Error saving: \(error.localizedDescription)")
                }
                
                // currentActionがnilでない場合のみisPushedをtrueにする
                isPushed = true
            }
        }
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: Binding<Bool>(
            get: { isPushed && currentAction != nil },
            set: { newValue in
                if !newValue {
                    isPushed = false
                }
            }
        )) {
            // currentActionを直接渡す
            if let action = currentAction {
                NormalLabelView(targetAction: Binding<TimelineItem>(
                    get: { action },
                    set: { currentAction = $0 }
                ), isPushed: isPushed)
            }
        }
    }
}

#Preview {
    NormalActionButton(timeline: .constant([]), teamName: "チーム1", actionName: "トライ", gameTime: TimeInterval(100))
}
