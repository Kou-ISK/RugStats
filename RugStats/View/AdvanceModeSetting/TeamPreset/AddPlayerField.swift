//
//  AddPlayerField.swift
//  RugStats
//
//  Created by 井坂航 on 2024/11/01.
//

import SwiftUI

struct AddPlayerField: View {
    @State private var newPlayerName = ""
    @Binding var team: TeamItem
    
    var body: some View {
        HStack{
            // 選手追加用のフィールド
            TextField("新規選手名", text: $newPlayerName)
                .padding()
            
            // 選手を追加するボタン
            Button(action: {
                addPlayer()
            }, label: {Image(systemName: "plus.circle.fill").tint(.green)})
        }
    }
    
    // 新しい選手をチームに追加する関数
    private func addPlayer() {
        guard !newPlayerName.isEmpty else { return }
        let newPlayer: PlayerItem = PlayerItem(name: newPlayerName)
        
        // 新しい選手をチームに追加
        team.players.append(newPlayer)
        
        // 入力フィールドをリセット
        newPlayerName = ""
    }
}

#Preview {
    AddPlayerField(team: .constant(TeamItem(name: "チーム")))
}
