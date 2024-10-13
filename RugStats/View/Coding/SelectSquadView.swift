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
        Text("出場メンバー選択")
        List(presetTeam.players, id:\.id){player in
            Text(player.name)
        }
        
        List(team.players, id: \.id){player in
            Text(player.name)
        }
    }
}

#Preview {
    SelectSquadView(team: .constant(GameTeamInfo(teamName: "チーム")), presetTeam: TeamItem(name: "チーム"))
}
