//
//  SelectSquadView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/13.
//

import SwiftUI

struct SelectSquadView: View {
    @Binding var team: GameTeamInfo
    
    var presetTeam: TeamItem
    
    var body: some View {
        VStack {
            // プリセットチームの選手リスト
            List(presetTeam.players, id: \.id) { player in
                HStack{
                    Button(action: {
                        selectPlayer(player)
                    }) {
                        if team.players.contains(player) {
                            ZStack{
                                Circle().fill(.blue)
                                Text(String(team.players.firstIndex(of: player)! + 1)).foregroundStyle(.white)
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
    }
    
    private func selectPlayer(_ player: PlayerItem) {
        if let index = team.players.firstIndex(of: player) {
            // 既に選択済みの場合は、選手を選択解除する
            team.players.remove(at: index)
        } else {
            // プレイヤーが選択済みでないか、最大人数を超えていないかを確認
            guard team.players.count < GameTeamInfo.maxPlayers else { return }
            team.players.append(player)
        }
    }
}

#Preview {
    SelectSquadView(team: .constant(GameTeamInfo(teamName: "チーム")), presetTeam: TeamItem(name: "チーム1"))
}
