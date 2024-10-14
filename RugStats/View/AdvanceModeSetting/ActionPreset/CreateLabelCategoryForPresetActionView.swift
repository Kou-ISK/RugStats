//
//  CreateLabelCategoryForPresetActionView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/11.
//

import SwiftUI

struct CreateLabelCategoryForPresetActionView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Binding var action: ActionLabelPresetItem
    
    @State private var newCategoryName: String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                // TODO: カテゴリ追加、一覧表示のUI修正
                HStack{
                    // カテゴリ名フィールド
                    TextField("カテゴリ", text: $newCategoryName)
                        .padding()
                    
                    // カテゴリを追加するボタン
                    Button(action: {
                        addCategory()
                    }, label: {Image(systemName: "plus.circle.fill").tint(.green)})
                }
                List($action.labelSet, id:\.id) { $labelSet in
                    NavigationLink(destination: CreateLabelView(category: labelSet), label: {Text(labelSet.categoryName)}).onTapGesture {
                        print("Tapped on \(labelSet.categoryName)")
                    }
                }
            }.onDisappear{
                do{
                    try modelContext.save()
                }catch{
                    print(error.localizedDescription)
                }
                
            }
        }.navigationTitle($action.actionName)
    }
    
    // 新しい選手をチームに追加する関数
    private func addCategory() {
        guard !newCategoryName.isEmpty else { return }
        
        // 新しいカテゴリをアクションに追加
        action.labelSet.append(ActionLabelCategory(categoryName: newCategoryName))
        
        // 入力フィールドをリセット
        newCategoryName = ""
    }
}

#Preview {
    CreateLabelCategoryForPresetActionView(action: .constant(ActionLabelPresetItem(actionName: "アクション", labelSet: [])))
}
