//
//  RugStatsApp.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import Combine
import SwiftUI
import SwiftData

@main
struct RugStatsApp: App {
    @State var isShowAlert: Bool = false
    
    private var appVersionModel = AppVersionModel()
    @State private var cancellables = Set<AnyCancellable>()
    
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
                .alert(isPresented: $isShowAlert){
                    return Alert(title: Text("新しいバージョンがあります"), message: Text("アップデートを行なってください"), primaryButton: .default(Text("App Storeを開く"), action: {
                        isShowAlert = false
                        if let url = URL(string: "https://apps.apple.com/jp/app/id6736402104"){
                            if UIApplication.shared.canOpenURL(url){
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    }), secondaryButton: .cancel(Text("あとで行う"), action: {
                        isShowAlert = false
                    }))
                }
                .onAppear{
                    appVersionModel.shouldRequestUpdate()
                        .sink(receiveValue: { shouldRequestUpdate in
                            if shouldRequestUpdate {
                                isShowAlert = true
                            }
                        })
                        .store(in: &cancellables)
                }
        }
    }
}
