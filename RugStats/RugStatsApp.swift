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
        let schema = Schema([
            GameItem.self,
            TimelineItem.self,
            TeamItem.self,
            ActionPresetItem.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
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
