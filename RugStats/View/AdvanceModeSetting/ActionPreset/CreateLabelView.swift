//
//  CreateLabelView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/14.
//
import SwiftUI

struct CreateLabelView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State var category: ActionLabelCategory
    
    @State private var newLabelName: String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                // TODO: ラベル追加、一覧表示のUI修正
                HStack{
                    // ラベルフィールド
                    TextField("ラベル", text: $newLabelName)
                        .padding()
                    
                    // ラベルを追加するボタン
                    Button(action: {
                        addLabel()
                    }, label: {Image(systemName: "plus.circle.fill").tint(.green)})
                }
                List{
                    ForEach($category.labels, id:\.id) { $label in
                        Text(label.label)
                    }.onDelete(perform: deleteLabel)
                }
            }.onDisappear{
                do{
                    try modelContext.save()
                }catch{
                    print(error.localizedDescription)
                }
                
            }
        }.navigationTitle(category.categoryName)
    }
    
    // 新しいラベルを追加する関数
    private func addLabel() {
        guard !newLabelName.isEmpty else { return }
        
        // 新しいラベルをチームに追加
        category.labels.append(ActionLabelItem(label: newLabelName, category: category))
        
        // 入力フィールドをリセット
        newLabelName = ""
    }
    
    private func deleteLabel(offsets: IndexSet) {
        // 削除対象のインデックスを元にアイテムを削除
         offsets.forEach { index in
             category.labels.remove(at: index)
         }
    }
}

#Preview {
    CreateLabelView(category: ActionLabelCategory(categoryName: "カテゴリ"))
}
