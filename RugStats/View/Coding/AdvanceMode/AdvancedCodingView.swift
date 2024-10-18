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
    
    init(gameInfo: Binding<GameItem>, gameClock: Binding<TimeInterval>, actionPresetList: [ActionPresetItem]) {
        self._gameInfo = gameInfo
        self._gameClock = gameClock
        self.actionPresetList = actionPresetList
        self._selectedActionPreset = State(initialValue: actionPresetList.first ?? ActionPresetItem(presetName: "デフォルト", actions: []))
    }
    
    var body: some View {
        NavigationStack{
            ForEach(selectedActionPreset.actions, id:\.id){action in
                // TODO: 個人スタッツ用のボタンセットを実装
                HStack{
                    // TODO: コンポーネントを切り出して実装
                    AdvancedActionButton(gameClock: $gameClock, timeline: $gameInfo.timeline, actorInfo: gameInfo.team1, action: action)
                    AdvancedActionButton(gameClock: $gameClock, timeline: $gameInfo.timeline, actorInfo: gameInfo.team2, action: action)
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
        }
    }
}

#Preview {
    AdvancedCodingView(gameInfo: .constant(GameItem(date: Date(), team1Name: "チーム1", team2Name: "チーム2")), gameClock: .constant(TimeInterval(100)), actionPresetList: [ActionPresetItem(presetName: "プリセット", actions: [ActionLabelPresetItem(actionName: "アクション", labelSet: [ActionLabelCategory(categoryName: "ラベル")])])])
}
