//
//  ContentView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var gameList: [GameItem]
    @Query private var teamList: [TeamItem]
    @Query private var actionPresetList: [ActionPresetItem]
    
    var body: some View {
        TabView{
            StartCodingView(teamPresetList: teamList, actionPresetList: actionPresetList)
                .tabItem {
                    Label("分析する", systemImage: "hand.tap")
                }
            
            StatsListView(gameList: gameList)
                .tabItem {
                    Label("ゲーム一覧", systemImage: "list.bullet")
                }
            
            AdvanceModeSettingView(actionPresetList: actionPresetList, teamList: teamList)
                .tabItem {
                    Label("アドバンスモード設定", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GameItem.self, inMemory: true)
}
