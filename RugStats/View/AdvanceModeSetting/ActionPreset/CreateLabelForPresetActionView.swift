//
//  CreateLabelForPresetActionView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/11.
//

import SwiftUI

struct CreateLabelForPresetActionView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Binding var action: ActionLabelPresetItem
    
    @State private var newLabelName: String = ""
    
    
    var body: some View {
        NavigationStack{
            VStack{
                // TODO: アクション追加、一覧表示のUI修正
                HStack{
                    // ラベル追加用のフィールド
                    TextField("ラベル", text: $newLabelName)
                        .padding()
                    
                    // ラベルを追加するボタン
                    Button(action: {
                        addLabel()
                    }, label: {Image(systemName: "plus.circle.fill").tint(.green)})
                }
                List($action.labelSet, id:\.id) { $label in
                    Text(label.label)
                }
            }.onDisappear{
                do{
                    try modelContext.save()
                }catch{
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    
    // 新しい選手をチームに追加する関数
    private func addLabel() {
        guard !newLabelName.isEmpty else { return }
        
        // 新しい選手をチームに追加
        action.labelSet.append(ActionLabelItem(label: newLabelName))
        
        // 入力フィールドをリセット
        newLabelName = ""
    }
}

#Preview {
    CreateLabelForPresetActionView(action: .constant(ActionLabelPresetItem(actionName: "アクション", labelSet: [])))
}
