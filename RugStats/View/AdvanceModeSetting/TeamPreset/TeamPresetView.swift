//
//  TeamPresetView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/11.
//

import SwiftUI

struct TeamPresetView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var team: TeamItem
    @State private var currentColor: Color = Color(.orange)
    
    @State private var isAddingPlayer: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    HStack{
                        TextField("チーム名", text: $team.name).font(.title)
                        ColorPicker("", selection: $currentColor, supportsOpacity: true)
                    }.padding(5)
                    if(isAddingPlayer){
                       // TODO: 選手追加用コンポーネントを追加
                    }
                    List{
                        ForEach($team.players, id:\.id){$player in
                            TextField("選手名", text: $player.name)
                        }.onDelete(perform: deleteMember)
                    }
                }
            }.toolbar{
                ToolbarItem(placement: .automatic){
                    Button(addPlayer ? "完了": "追加"){
                        addPlayer.toggle()
                    }
                }
            }.navigationTitle("チーム情報")
        }
        .onAppear{
            setCurrentColor()
        }
        .onDisappear{
            // 画面遷移時に保存
            saveCurrentColor()
            do {
                try modelContext.save()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    private func setCurrentColor(){
        currentColor = Color(cgColor: CGColor(red: team.teamColor?.red ?? 0, green: team.teamColor?.green ?? 0, blue: team.teamColor?.blue ?? 0, alpha: team.teamColor?.alpha ?? 0))
    }
    
    private func saveCurrentColor(){
        // RGB 成分を取得
        if let rgb = currentColor.toRGB(){
            // ColorItem を作成
            let newTeamColor = ColorItem(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha:rgb.alpha)
            team.teamColor = newTeamColor
        }
    }
    
    private func deleteMember(offsets: IndexSet) {
        // 削除対象のインデックスを元にアイテムを削除
         offsets.forEach { index in
             team.players.remove(at: index)
         }
    }
}

#Preview {
    TeamPresetView(team: .constant(TeamItem(name: "チーム")))
}
