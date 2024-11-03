//
//  ActorPicker.swift
//  RugStats
//
//  Created by 井坂航 on 2024/11/03.
//

import SwiftUI

struct ActorPicker: View {
    @Binding var selectedActor: String
    
    var timeline: [TimelineItem]
    // アクション名のリスト
    private var actorNames: [String] {
        Array(Set(timeline.map { $0.actorName })).sorted()
    }
    
    var body: some View {
        // Pickerでアクションを選択
        Picker("アクションを選択", selection: $selectedActor) {
            ForEach(actorNames, id: \.self) { actor in
                Text(actor).tag(actor)
            }
        }
        .pickerStyle(SegmentedPickerStyle()) // セグメント形式のPickerスタイル
    }
}

#Preview {
    ActorPicker(selectedActor: .constant("チーム1"), timeline: [TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), actorName: "チーム1", actionName: "タックル")])
}
