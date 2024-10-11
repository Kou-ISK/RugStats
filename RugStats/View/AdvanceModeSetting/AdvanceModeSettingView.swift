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
                // TODO: アクション、チームプリセット作成時に画面に即時反映されない問題に対処
                // この画面でStateとして管理している変数を渡す必要があるか
                NavigationLink("アクションプリセット", destination: ActionPresetListView(actionPresetList: $actionPresetList))
                NavigationLink("チームプリセット", destination: TeamPresetListView(teamList: $teamList))
            }
        }
    }
}

#Preview {
    AdvanceModeSettingView(actionPresetList: [ActionPresetItem(presetName: "プリセット1", actions: [])], teamList: [TeamItem(name: "チーム")])
}
