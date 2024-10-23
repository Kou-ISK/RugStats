//
//  TeamPicker.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/12.
//

import SwiftUI

struct TeamPicker: View {
    @Binding var newTeam: GameTeamInfo
    @State private var isSelectTeam: Bool = true // デフォルトは選択モード
    @State private var presetTeam: TeamItem?
    
    var teamPresetList: [TeamItem]
    
    var body: some View {
        VStack {
            HStack{
                // 入力モードと選択モードを切り替えるセグメント
                Picker("", selection: $isSelectTeam) {
                    Text("選択").tag(true)
                    Text("入力").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 100)
                
                // チーム名の入力または選択
                if isSelectTeam {
                    Picker("", selection: $newTeam.teamName) {
                        // デフォルトの「チームを選択」オプション
                        Text("チームを選択").tag("")
                        
                        // チームのリストを表示
                        ForEach(teamPresetList, id: \.self) { team in
                            Text(team.name).tag(team.name)
                        }
                    }
                    .onChange(of: newTeam.teamName) { _, newTeamName in
                        if let selectedTeam = teamPresetList.first(where: { $0.name == newTeamName }) {
                            newTeam.teamColor = selectedTeam.teamColor
                            presetTeam = selectedTeam
                        } else {
                            // 「チームを選択」が選ばれた場合は選択を解除
                            presetTeam = nil
                            newTeam.teamColor = nil
                        }
                    }.pickerStyle(.menu)
                    
                } else {
                    TextField("チーム名を入力", text: $newTeam.teamName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            
            // メンバー選択画面への遷移
            NavigationLink(destination: SelectSquadView(team: $newTeam, presetTeam: presetTeam ?? TeamItem(name: "デフォルト"))) {
                Text("メンバー選択")
            }
            .buttonStyle(.bordered)
            .disabled(!isSelectTeam || presetTeam == nil)
        }
    }
}

#Preview {
    TeamPicker(newTeam: .constant(GameTeamInfo(teamName: "チーム")), teamPresetList: [TeamItem(name: "チームA"), TeamItem(name: "チームB")])
}
