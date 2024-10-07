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
    
    // TODO 空文字でコミットできないようにする
    var body: some View {
        VStack {
            if isEditing {
                TextField("入力", text: $text, onCommit: {
                    // 編集終了時に呼ばれる
                    isEditing = false
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(text)
                    .onTapGesture {
                        isEditing = true
                    }
            }
        }
        .padding()
    }
}

#Preview {
    EditableTextView(text: .constant("text"))
}
