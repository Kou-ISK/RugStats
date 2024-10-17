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
        NavigationStack{
            VStack{
                List($teamList, id:\.id){$team in
                    NavigationLink(destination: {TeamPresetView(team: $team)}, label: {
                        HStack{
                            Text(team.name)
                            Spacer()
                            Circle().fill(Color(CGColor(red: team.teamColor?.red ?? 0, green: team.teamColor?.green ?? 0, blue: team.teamColor?.blue ?? 0, alpha: team.teamColor?.alpha ?? 0))).frame(width: 20)
                        }
                    })
                }
            }.navigationTitle("チームプリセット一覧")
            .toolbar(content: {
                ToolbarItem(placement: .automatic ,content: {
                    NavigationLink(destination: CreateTeamPresetView(teamList: $teamList), label: {
                        Image(systemName: "square.and.pencil")
                    })})
            })
        }
    }
}

#Preview {
    TeamPresetListView(teamList: .constant([TeamItem(name: "チーム")]))
}
