//
//  ActionPresetLabelView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/11.
//

import SwiftUI

struct ActionPresetLabelView: View {
    @Environment(\.modelContext)private var modelContext
    @Binding var action: ActionLabelPresetItem
    
    var body: some View {
        ForEach($action.labelSet, id:\.id){$category in
            TextField("カテゴリー", text: $category.categoryName)
            List{
                ForEach($category.labels, id:\.id){$label in
                    TextField("ラベル", text: $label.label)
                }.onDelete(perform: deleteLabel)
            }
        }
    }
    
    private func deleteLabel(offsets: IndexSet) {
        // offsetsから削除するアイテムを取得
        offsets.map { action.labelSet[$0] }.forEach { label in
            // modelContextから削除
            modelContext.delete(label)
        }
        do {
            // モデルコンテキストの保存
            try modelContext.save()
        } catch {
            print("削除エラー: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ActionPresetLabelView(action: .constant(ActionLabelPresetItem(actionName: "アクション", labelSet: [ActionLabelCategory(categoryName: "ラベル")])))
}
