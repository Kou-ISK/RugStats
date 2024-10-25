//
//  AdvancedCodingView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/12.
//

import SwiftUI

struct AdvancedCodingView: View {
    @Binding var gameInfo: GameItem
    @Binding var gameClock: TimeInterval // ストップウォッチの経過時間
    @State var actionPresetList: [ActionPresetItem]
    @State private var selectedActionPreset: ActionPresetItem
    @State private var selectedTeam: GameTeamInfo
    @State private var currentMode:Mode = .team
    
    // モードを定義
    enum Mode: CaseIterable {
        case team
        case individual
        
        // ローカライズされた表示名を提供するプロパティ
        var displayName: String {
            switch self {
                case .team:
                    return NSLocalizedString("Team", comment: "")
                case .individual:
                    return NSLocalizedString("Individual", comment: "")
            }
        }
    }
    
    init(gameInfo: Binding<GameItem>, gameClock: Binding<TimeInterval>, actionPresetList: [ActionPresetItem]) {
        self._gameInfo = gameInfo
        self._gameClock = gameClock
        self.actionPresetList = actionPresetList
        self._selectedActionPreset = State(initialValue: actionPresetList.first ?? ActionPresetItem(presetName: "デフォルト", actions: []))
        self._selectedTeam = State(initialValue: gameInfo.wrappedValue.team1)
    }
    
    var body: some View {
        NavigationStack{
            // Pickerを使ってモードを切り替える
            Picker("表示モード", selection: $currentMode) {
                ForEach(Mode.allCases, id: \.self) { mode in
                    Text(mode.displayName).tag(mode)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            // 選択されたモードに応じて表示を切り替える
            switch currentMode {
                case .team:
                    ForEach($selectedActionPreset.actions, id:\.id){$action in
                        HStack{
                            // TODO: コンポーネントを切り出して実装
                            AdvancedActionButton(gameClock: $gameClock, timeline: $gameInfo.timeline, actorName: gameInfo.team1.teamName, actorColor:gameInfo.team1.teamColor, action: action)
                            AdvancedActionButton(gameClock: $gameClock, timeline: $gameInfo.timeline, actorName: gameInfo.team2.teamName, action: action)
                        }
                    }
                case .individual:
                    ScrollView(.vertical){
                        // Pickerを使ってチームを切り替える
                        Picker("表示モード", selection: $selectedTeam) {
                            Text(gameInfo.team1.teamName).tag(gameInfo.team1)
                            Text(gameInfo.team2.teamName).tag(gameInfo.team2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        ForEach(selectedTeam.players, id: \.id) {player in
                            HStack {
                                Text(player.name)
                                ForEach(selectedActionPreset.actions, id: \.id) { action in
                                    AdvancedActionButton(gameClock: $gameClock, timeline: $gameInfo.timeline, actorName: player.name, actorColor: selectedTeam.teamColor, action: action)
                                }
                            }
                        }
                    }
            }
            
            
            AdvancedStatsTableView(timeline: $gameInfo.timeline)
        }.toolbar{
            ToolbarItem(placement: .automatic){
                Picker("プリセット", selection: $selectedActionPreset) {
                    ForEach(actionPresetList, id: \.self) { preset in
                        Text(preset.presetName).tag(preset.presetName)
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: selectedActionPreset) { oldPresetName, newPresetName in
                    if let selectedPreset = actionPresetList.first(where: { $0.presetName == newPresetName.presetName}) {
                        selectedActionPreset = selectedPreset
                    }
                }
            }
        }.onAppear{
            // TODO: デフォルト値を扱えるようにするより良い方法がないか検討
            actionPresetList.append(contentsOf: DefaultItem().defaultActionPresets)
        }
    }
}

#Preview {
    AdvancedCodingView(gameInfo: .constant(GameItem(date: Date(), team1Name: "チーム1", team2Name: "チーム2")), gameClock: .constant(TimeInterval(100)), actionPresetList: [ActionPresetItem(presetName: "プリセット", actions: [ActionLabelPresetItem(actionName: "アクション", labelSet: [ActionLabelCategory(categoryName: "ラベル")])])])
}
