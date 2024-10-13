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
    
    @State private var presetTeam: TeamItem?
    
    var teamPresetList: [TeamItem]
    
    var body: some View {
        VStack{
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
                    .onChange(of: newTeam.teamName) { oldTeamName, newTeamName in
                        if let selectedTeam = teamPresetList.first(where: { $0.name == newTeamName }) {
                            // TeamItem.teamColorをGameTeamInfo.teamColorに設定
                            newTeam.teamColor = selectedTeam.teamColor
                            presetTeam = selectedTeam
                        }
                    }
                }
                Toggle("カスタム入力", isOn: $isCustomTeam)
            }
            // NavigationLinkで画面遷移前にチームの更新を行う
            NavigationLink(
                destination: SelectSquadView(team: $newTeam, presetTeam: presetTeam ?? TeamItem(name: "デフォルト"))
                    .disabled((presetTeam == nil))
            ) {
                Text("メンバー選択")
            }
        }
    }
}

#Preview {
    TeamPicker(newTeam: .constant(GameTeamInfo(teamName: "チーム")), teamPresetList: [TeamItem(name: "チーム")])
}
