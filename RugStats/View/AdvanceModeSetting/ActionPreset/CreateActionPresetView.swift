//
//  CreateActionPresetView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/11.
//

import SwiftUI

struct CreateActionPresetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Binding var actionPresetList: [ActionPresetItem]
    
    @State private var newActionPreset: ActionPresetItem = ActionPresetItem(presetName: "", actions: [])
    @State private var newActionName: String = ""
    
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("プリセット名", text: $newActionPreset.presetName).padding()
                // TODO: アクション追加、一覧表示のUI修正
                
                HStack{
                    // アクション追加用のフィールド
                    TextField("アクション名", text: $newActionName)
                        .padding()
                    
                    // アクションを追加するボタン
                    Button(action: {
                        addAction()
                    }, label: {Image(systemName: "plus.circle.fill").tint(.green)})
                }
                Section("アクション一覧"){
                    List($newActionPreset.actions, id:\.id) { $action in
                        NavigationLink(destination: CreateLabelCategoryForPresetActionView(action: $action), label: {Text(action.actionName)})
                    }
                }
                
                Button("新規プリセット作成"){
                    actionPresetList.append(newActionPreset)
                    modelContext.insert(newActionPreset)
                    do{
                        try modelContext.save()
                    }catch{
                        print(error.localizedDescription)
                    }
                    dismiss()
                }.buttonStyle(.borderedProminent)
            }.padding().navigationTitle("アクションプリセット作成")
        }
    }
    
    // 新しい選手をチームに追加する関数
    private func addAction() {
        guard !newActionName.isEmpty else { return }
        let newAction: ActionLabelPresetItem = ActionLabelPresetItem(actionName: newActionName, labelSet: [])
        
        // 新しい選手をチームに追加
        newActionPreset.actions.append(newAction)
        
        // 入力フィールドをリセット
        newActionName = ""
    }
}

#Preview {
    CreateActionPresetView(actionPresetList: .constant([ActionPresetItem(presetName: "プリセット1", actions: [ActionLabelPresetItem(actionName: "アクション", labelSet: [ActionLabelCategory(categoryName: "ラベル")])])]))
}
