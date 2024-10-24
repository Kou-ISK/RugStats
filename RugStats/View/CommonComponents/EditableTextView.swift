//
//  EditableTextView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/07.
//

import SwiftUI

struct EditableTextView: View {
    @State private var isEditing: Bool = false
    @Binding var text: String
    
    var width: CGFloat
    
    // TODO 空文字でコミットできないようにする
    var body: some View {
        if isEditing {
            TextField("入力", text: $text, onCommit: {
                // 編集終了時に呼ばれる
                isEditing = false
            }).frame(minWidth: width)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        } else {
            Text(text).frame(width: width)
                .onTapGesture {
                    isEditing = true
                }
        }
    }
}

#Preview {
    EditableTextView(text: .constant("text"), width: 100)
}
