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
            List(presetTeam.players, id: \.id) { player in
                HStack {
                    Button(action: {
                        team.togglePlayer(player)
                    }) {
                        if team.orderedPlayers().contains(player) {
                            let playerIndex = team.orderedPlayers().firstIndex(of: player)! + 1
                            ZStack {
                                Circle().fill(.blue)
                                Text(String(playerIndex)).foregroundStyle(.white)
                            }
                            .frame(width: 25, height: 25)
                        } else {
                            Circle().stroke(.blue).frame(width: 25, height: 25)
                        }
                    }
                    Text(player.name)
                }
            }
        }
        .navigationTitle("選手選択")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    SelectSquadView(team: .constant(GameTeamInfo(teamName: "チーム")), presetTeam: TeamItem(name: "チーム1"))
}
