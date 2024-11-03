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
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    TextField("チーム名", text: $newTeam.name).padding()
                    ColorPicker("", selection: $currentColor, supportsOpacity: true)
                }
                
                // TODO: 選手追加、選手一覧表示のUI修正
                // 選手追加フィールド
                AddPlayerField(team: $newTeam)
                // 選手一覧
                Section("選手一覧"){
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
}

#Preview {
    CreateTeamPresetView(teamList: .constant([TeamItem(name: "チーム")]))
}
