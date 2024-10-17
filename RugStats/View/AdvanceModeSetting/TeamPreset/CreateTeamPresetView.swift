//
//  CreateTeamPresetView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/09.
//

import SwiftUI

struct CreateTeamPresetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Binding var teamList: [TeamItem]
    
    // 一時的にチームカラーを保持する変数
    @State private var currentColor: Color = Color(.white)
    @State private var newTeam: TeamItem = TeamItem(name: "")
    
    // 選手の追加用の状態変数
    @State private var newPlayerName: String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("チーム名", text: $newTeam.name)
                ColorPicker("チームカラー選択", selection: $currentColor, supportsOpacity: true)
                
                // TODO: 選手追加、選手一覧表示のUI修正
                Section("選手一覧"){
                    // 現在のチームの選手リスト表示
                    HStack{
                        // 選手追加用のフィールド
                        TextField("新規選手名", text: $newPlayerName)
                            .padding()
                        
                        // 選手を追加するボタン
                        Button(action: {
                            addPlayer()
                        }, label: {Image(systemName: "plus.circle.fill").tint(.green)})
                    }
                    List(newTeam.players, id:\.id) { player in
                        Text(player.name)
                    }
                }
                
                
                Button("新規チーム作成"){
                    // RGB 成分を取得
                    if let rgb = currentColor.toRGB(){
                        // ColorItem を作成
                        let newTeamColor = ColorItem(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha:rgb.alpha)
                        newTeam.teamColor = newTeamColor
                    }
                    teamList.append(newTeam)
                    modelContext.insert(newTeam)
                    do{
                        try modelContext.save()
                    }catch{
                        print(error.localizedDescription)
                    }
                    dismiss()
                }.buttonStyle(.borderedProminent)
            }.padding().navigationTitle("チームプリセット作成")
        }
    }
    
    // 新しい選手をチームに追加する関数
    private func addPlayer() {
        guard !newPlayerName.isEmpty else { return }
        let newPlayer: PlayerItem = PlayerItem(name: newPlayerName)
        
        // 新しい選手をチームに追加
        newTeam.players.append(newPlayer)
        
        // 入力フィールドをリセット
        newPlayerName = ""
    }
}


#Preview {
    CreateTeamPresetView(teamList: .constant([TeamItem(name: "チーム")]))
}
