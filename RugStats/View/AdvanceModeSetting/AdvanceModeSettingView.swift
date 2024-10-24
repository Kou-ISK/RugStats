//
//  AdvanceModeSettingView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/09.
//

import SwiftUI

struct AdvanceModeSettingView: View {
    @State var actionPresetList: [ActionPresetItem]
    @State var teamList: [TeamItem]
    
    var body: some View {
        NavigationStack{
            List{
                NavigationLink("アクションプリセット", destination: ActionPresetListView(actionPresetList: $actionPresetList))
                NavigationLink("チームプリセット", destination: TeamPresetListView(teamList: $teamList))
            }
        }
    }
}

#Preview {
    AdvanceModeSettingView(actionPresetList: [ActionPresetItem(presetName: "プリセット1", actions: [])], teamList: [TeamItem(name: "チーム")])
}
