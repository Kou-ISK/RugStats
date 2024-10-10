//
//  AdvanceModeSettingView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/09.
//

import SwiftUI

struct AdvanceModeSettingView: View {
    @State var teamList: [TeamItem]
    
    var body: some View {
        NavigationStack{
            VStack{
                NavigationLink("チームプリセット作成", destination: CreateTeamPresetView())
                
                // TODO: 遷移先画面を作成
                NavigationLink("アクションプリセット作成", destination: EmptyView())
                
                // TODO: プリセット一覧画面を作成
                NavigationLink("チームプリセット確認", destination: TeamPresetListView(teamList: $teamList))
            }
        }
    }
}

#Preview {
    AdvanceModeSettingView(teamList: [TeamItem(name: "チーム")])
}
