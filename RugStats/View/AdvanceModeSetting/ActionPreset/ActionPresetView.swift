//
//  ActionPresetView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/11.
//

import SwiftUI

struct ActionPresetView: View {
    @Environment(\.modelContext)private var modelContext
    
    @Binding var actionPreset: ActionPresetItem
    
    var body: some View {
        TextField("プリセット名", text: $actionPreset.presetName)
        List{
            ForEach($actionPreset.actions, id:\.id){$action in
                NavigationLink(destination: ActionPresetLabelView(action: $action), label: {
                    TextField("アクション名", text: $action.actionName)
                })
            }.onDelete(perform: deletePreset)
        }
    }
    
    private func deletePreset(offsets: IndexSet) {
        // offsetsから削除するアイテムを取得
        offsets.map { actionPreset.actions[$0] }.forEach { preset in
            // modelContextから削除
            modelContext.delete(preset)
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
    ActionPresetView(actionPreset: .constant(ActionPresetItem(presetName: "プリセット名", actions: [ActionLabelPresetItem(actionName: "アクション", labelSet: [ActionLabelCategory(categoryName: "ラベル")])])))
}
