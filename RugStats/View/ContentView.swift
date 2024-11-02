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
    
    // actionPresetListにDefaultItemの要素が存在しない場合に追加
    private func addDefaultActionPresetIfNeeded() {
        let defaultActionPresets = DefaultItem().defaultActionPresets
        
        // actionPresetListにないプリセットをフィルタリング
        let presetsToAdd = defaultActionPresets.filter { defaultPreset in
            !actionPresetList.contains(where: { $0.presetName == defaultPreset.presetName })
        }
        
        // 必要なプリセットのみをmodelContextに追加
        for preset in presetsToAdd {
            modelContext.insert(preset)
        }
        
        // データベースに保存
        if !presetsToAdd.isEmpty {
            do {
                try modelContext.save()
                print("\(presetsToAdd.count) default items were added to actionPresetList.")
            } catch {
                print("Failed to save DefaultItem: \(error.localizedDescription)")
            }
        } else {
            print("No new default items were needed.")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GameItem.self, inMemory: true)
}
