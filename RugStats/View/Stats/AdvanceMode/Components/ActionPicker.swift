//
//  ActionPicker.swift
//  RugStats
//
//  Created by 井坂航 on 2024/11/03.
//

import SwiftUI

struct ActionPicker: View {
    @Binding var selectedAction: String
    var timeline: [TimelineItem]
    
    // アクション名のリスト
    private var actionNames: [String] {
        Array(Set(timeline.map { $0.actionName })).sorted()
    }
    
    var body: some View {
        // Pickerでアクションを選択
        Picker("アクションを選択", selection: $selectedAction) {
            ForEach(actionNames, id: \.self) { action in
                Text(action).tag(action)
            }
        }
        .pickerStyle(.menu) // セグメント形式のPickerスタイル
        .onAppear{
            selectedAction = actionNames.first ?? ""
        }
    }
}

#Preview {
    ActionPicker(selectedAction: .constant(""), timeline: [TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), actorName: "チーム1", actionName: "タックル")])
}
