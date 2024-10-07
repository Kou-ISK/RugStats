//
//  NormalStatsTableRow.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/06.
//

import SwiftUI

struct NormalStatsTableRow: View {
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
                    EditableTextView(text: $label.label, width: 100)
                        .frame(alignment: .leading)
                }
            }
            Text(formatTimeInterval(item.gameClock))
                .frame(width: 50, alignment: .leading)
            Text(dateFormatter.string(from: item.timestamp))
                .frame(width: 100, alignment: .leading)
        }.onChange(of: item.actorName) {
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
    private func formatTimeInterval(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    NormalStatsTableRow(item: .constant(TimelineItem(timestamp: Date(), gameClock: TimeInterval(300), actorName: "チーム1", actionName: "トライ")))
}