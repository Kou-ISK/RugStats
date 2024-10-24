//
//  AdvancedStatsTableRow.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/17.
//

import SwiftUI

struct AdvancedStatsTableRow: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var item: TimelineItem
    var body: some View {
        HStack {
            EditableTextView(text: $item.actorName, width: 100)
                .frame(alignment: .leading)
            EditableTextView(text: $item.actionName, width: 100)
                .frame(alignment: .leading)
            
            VStack{
                ForEach($item.actionLabels, id:\.id){$label in
                    EditableTextView(text: $label.label, width: 150)
                        .frame(alignment: .leading)
                }
            }.frame(minWidth: 150)
            Text("(\(item.startXcoord ?? 0),\(item.startYcoord ?? 0))")
                .frame(width: 100, alignment: .leading)
            Text("(\(item.endXcoord ?? 0),\(item.endYcoord ?? 0))")
                .frame(width: 100, alignment: .leading)
            Text(formatTimeInterval(item.startGameClock))
                .frame(width: 100, alignment: .leading)
            Text(formatTimeInterval(item.endGameClock))
                .frame(width: 100, alignment: .leading)
            Text(dateFormatter.string(from: item.startTimestamp))
                .frame(width: 100, alignment: .leading)
        }.padding(0).onChange(of: item.actorName) {
            saveChanges()
        }
        .onChange(of: item.actionName) {
            saveChanges()
        }
        .onChange(of: item.actionLabels) {
            saveChanges()
        }
    }
    
    private func saveChanges() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save changes: \(error.localizedDescription)")
        }
    }
    
    // DateFormatter はプロパティの初期化内で設定する
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter
    }()
    
    // ゲームクロックをフォーマットする関数
    private func formatTimeInterval(_ time: TimeInterval?) -> String {
        guard let time = time else { return "なし" }
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    NormalStatsTableRow(item: .constant(TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(300), actorName: "チーム1", actionName: "トライ")))
}
