//
//  TeamPresetListView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/10.
//

import SwiftUI

struct TeamPresetListView: View {
    @Binding var teamList: [TeamItem]
    var body: some View {
        VStack{
            List($teamList, id:\.id){$team in
                HStack{
                    Text(team.name)
                    // TODO: 円のサイズを変更
                    Circle().fill(Color(CGColor(red: team.teamColor?.red ?? 0, green: team.teamColor?.green ?? 0, blue: team.teamColor?.blue ?? 0, alpha: team.teamColor?.alpha ?? 0)))
                }
            }
        }
    }
}

#Preview {
    TeamPresetListView(teamList: .constant([TeamItem(name: "チーム")]))
}
