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
                List($category.labels, id:\.id) { $label in
                    Text(label.label)
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
    
    // 新しい選手をチームに追加する関数
    private func addLabel() {
        guard !newLabelName.isEmpty else { return }
        
        // 新しい選手をチームに追加
        category.labels.append(ActionLabelItem(label: newLabelName))
        
        // 入力フィールドをリセット
        newLabelName = ""
    }
}

#Preview {
    CreateLabelView(category: ActionLabelCategory(categoryName: "カテゴリ"))
}
