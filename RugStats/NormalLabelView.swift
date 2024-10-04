//
//  NormalLabelView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/03.
//

import SwiftUI

struct NormalLabelView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Binding var targetAction: TimelineItem
    
    var zoneList = ["敵陣22m-トライライン", "敵陣10m-敵陣22m", "自陣10m-敵陣10m", "自陣22m-自陣10m", "自陣トライライン-自陣22m"]
    var laneList = ["左", "中央", "右"]
    
    var body: some View {
        VStack {
            ForEach(zoneList, id: \.self) { zone in
                HStack {
                    ForEach(laneList, id: \.self) { lane in
                        Button("\(zone)\n\(lane)") {
                            print("\(zone) \(lane)")
                            // ラベルを付与する
                            targetAction.actionLabels.append(zone)
                            targetAction.actionLabels.append(lane)
                            
                            // modelContextに保存
                            saveLabel()
                            
                            // モーダルを閉じる
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
    }
    
    private func saveLabel(){
        modelContext.insert(targetAction)
        do {
            try modelContext.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }

    }
}


#Preview {
    NormalLabelView(targetAction: .constant(TimelineItem(timestamp: Date(), gameClock: TimeInterval(10), actorName: "チーム1", actionName: "トライ")))
}
