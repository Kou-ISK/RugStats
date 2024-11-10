//
//  RugStatsApp.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI
import SwiftData

@main
struct RugStatsApp: App {
    var sharedModelContainer: ModelContainer = {
        // スキーマを定義
        let schema = Schema([
            GameItem.self,
            TimelineItem.self,
            TeamItem.self,
            ActionPresetItem.self,
            ActionLabelItem.self,
            ActionLabelCategory.self
        ])

        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            // 変更がない場合はマイグレーション計画を指定しない
            return try ModelContainer(
                for: schema,
                migrationPlan: ActionLabelMigrationPlan.self,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView().modelContainer(sharedModelContainer)
        }
    }
}
