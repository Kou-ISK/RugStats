//
//  ActorPicker.swift
//  RugStats
//
//  Created by 井坂航 on 2024/11/03.
//

import SwiftUI

struct ActorPicker: View {
    @Binding var selectedActor: String
    @State private var selectedTeam: GameTeamInfo?
    
    var timeline: [TimelineItem]
    var teamList: [GameTeamInfo]
    
    // タイムラインに含まれるアクター名を抽出
    private var actorNames: Set<String> {
        Set(timeline.map { $0.actorName })
    }
    
    // チーム名をキーに、タイムラインに含まれる選手名を値として格納した辞書
    private var filteredTeamList: [String: [String]] {
        var teamDictionary: [String: [String]] = [:]
        
        teamList.forEach { team in
            // チームに所属する選手のうち、タイムラインに含まれる選手のみを抽出
            let filteredPlayers = team.players
                .map { $0.player.name }
                .filter { actorNames.contains($0) }
            
            // チーム名をキーに、フィルタリングされた選手名リストを値として辞書に追加
            teamDictionary[team.teamName] = filteredPlayers
        }
        
        return teamDictionary
    }
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedActor) {
                // チーム名を表示
                ForEach(filteredTeamList.keys.sorted(), id: \.self) { teamName in
                    Text(teamName).tag(teamName)
                }
                
                // チームごとの選手を「チーム名 - 選手名」形式で表示
                ForEach(filteredTeamList.keys.sorted(), id: \.self) { teamName in
                    if let players = filteredTeamList[teamName] {
                        ForEach(players, id: \.self) { playerName in
                            Text("\(teamName) - \(playerName)").tag(playerName)
                        }
                    }
                }
            }
            .pickerStyle(.menu)
            .onAppear {
                // 初期選択を最初のチームに設定
                if let firstTeam = filteredTeamList.first {
                    selectedActor = firstTeam.key
                }
            }
        }
    }
}

#Preview {
    ActorPicker(selectedActor: .constant("チーム1"), timeline: [
        TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), actorName: "チーム1", actionName: "タックル"),
        TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(120), actorName: "プレーヤーA", actionName: "タックル"),
        TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(150), actorName: "プレーヤーB", actionName: "タックル")
    ], teamList: [
        GameTeamInfo(teamName: "チーム1"),
        GameTeamInfo(teamName: "チーム2")
    ])
}
