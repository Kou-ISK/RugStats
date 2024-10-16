//
//  AdvancedLabelView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/15.
//

import SwiftUI

struct AdvancedLabelView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Binding var action: TimelineItem
    var labelSet: [ActionLabelCategory]
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(labelSet, id: \.id) { category in
                    Text(category.categoryName)
                    ForEach(category.labels, id: \.id) { label in
                        Button(action: {
                            action.actionLabels.append(label)
                        }, label: {
                            Text(label.label)
                        })
                    }
                }
            }
            .navigationTitle("ラベル追加")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("完了") {
                        do {
                            try modelContext.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AdvancedLabelView(action: .constant(TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), actorName: "チーム1", actionName: "タックル")), labelSet: [ActionLabelCategory(categoryName: "カテゴリ")])
}
