//
//  ActionPresetListView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/11.
//

import SwiftUI

struct ActionPresetListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var actionPresetList: [ActionPresetItem]
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach($actionPresetList, id:\.id){ $actionPreset in
                        NavigationLink(destination: {
                            ActionPresetView(actionPreset: $actionPreset)
                        }, label: {
                            Text(actionPreset.presetName)
                        })
                    }.onDelete(perform: deletePreset)
                }
            }.toolbar(content: {
                ToolbarItem(placement: .automatic ,content: {
                    NavigationLink(destination: CreateActionPresetView(actionPresetList: $actionPresetList), label: {
                        Image(systemName: "square.and.pencil")
                    })})
            })
        }
    }
    
    private func deletePreset(offsets: IndexSet) {
        // offsetsから削除するアイテムを取得
        offsets.map { actionPresetList[$0] }.forEach { preset in
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
    ActionPresetListView(actionPresetList: .constant([ActionPresetItem(presetName: "プリセット1", actions: [ActionLabelPresetItem(actionName: "タックル", labelSet: [ActionLabelCategory(categoryName: "ラベル")])])]))
}
