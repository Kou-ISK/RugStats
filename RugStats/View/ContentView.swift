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
        }.onAppear{
            addDefaultActionPresetIfNeeded()
        }
    }
    
    // TODO: actionPresetListにDefaultItemの要素が存在しない場合に追加できるようにする
    private func addDefaultActionPresetIfNeeded() {
        // actionPresetListが空の場合
        if !actionPresetList.isEmpty {
            let defaultActionPresets = DefaultItem().defaultActionPresets
            // defaultActionPresets の各要素を modelContext に追加
            for preset in defaultActionPresets {
                modelContext.insert(preset)
            }
            
            // データベースに保存
            do {
                try modelContext.save()
                print("DefaultItem was added to actionPresetList.")
            } catch {
                print("Failed to save DefaultItem: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GameItem.self, inMemory: true)
}
