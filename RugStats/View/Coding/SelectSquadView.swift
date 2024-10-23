//
//  SelectSquadView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/13.
//

import SwiftUI

struct SelectSquadView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var team: GameTeamInfo
    @State private var selectedPlayers: [PlayerItem] = [] // 選択されたプレイヤーを保持する配列
    
    var presetTeam: TeamItem
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("出場メンバー選択")
                    .font(.headline)
                    .padding()
                
                // プリセットチームの選手リスト
                List(presetTeam.players, id: \.id) { player in
                    HStack{
                        Button(action: {
                            selectPlayer(player)
                        }) {
                            if selectedPlayers.contains(player) {
                                ZStack{
                                    Circle().fill(.blue)
                                    Text(String(selectedPlayers.firstIndex(of: player)! + 1)).foregroundStyle(.white)
                                }.frame(width: 25, height: 25)
                            }else{
                                Circle().stroke(.blue).frame(width:25, height:25)
                            }
                        }
                        Text(player.name)
                    }
                }
            }.navigationTitle("選手選択")
                .navigationBarTitleDisplayMode(.inline)
        }.toolbar{
            ToolbarItem(placement: .topBarTrailing){
                // 完了ボタン
                Button("完了"){
                    team.players = selectedPlayers
                    dismiss()
                }
                .disabled(selectedPlayers.isEmpty) // 選手が選ばれていない場合は無効化
                .padding()
            }
        }
    }
    
    private func selectPlayer(_ player: PlayerItem) {
        if let index = selectedPlayers.firstIndex(of: player) {
            // 既に選択済みの場合は、選手を選択解除する
            selectedPlayers.remove(at: index)
        } else {
            // プレイヤーが選択済みでないか、最大人数を超えていないかを確認
            guard selectedPlayers.count < GameTeamInfo.maxPlayers else { return }
            selectedPlayers.append(player) // プレイヤーを選択
        }
    }
}

#Preview {
    SelectSquadView(team: .constant(GameTeamInfo(teamName: "チーム")), presetTeam: TeamItem(name: "チーム1"))
}
