//
//  TeamPicker.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/12.
//

import SwiftUI

struct TeamPicker: View {
    @Binding var newTeam: GameTeamInfo
    @State private var isCustomTeam:Bool = false
    
    var teamPresetList: [TeamItem]
    
    var body: some View {
        // チームの選択または入力
        HStack{
            if isCustomTeam {
                TextField("チーム名を入力", text: $newTeam.teamName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else{
                Picker("チーム名", selection: $newTeam.teamName) {
                    ForEach(teamPresetList, id: \.self) { team in
                        Text(team.name).tag(team.name)
                    }
                }
                .pickerStyle(.menu)
                // TODO: Teamを選択した時にTeamItem.teamColorをGameTeamInfo.teamColorに入れる
            }
            Toggle("カスタムチーム名を入力", isOn: $isCustomTeam)
        }
    }
}

#Preview {
    TeamPicker(newTeam: .constant(GameTeamInfo(teamName: "チーム")), teamPresetList: [TeamItem(name: "チーム")])
}
