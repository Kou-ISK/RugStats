//
//  MigrationPlan.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/26.
//

import Foundation
import SwiftData

// 初期バージョン (V0) を定義
struct ActionLabelSchemaV0: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(0, 0, 0)
    static var models: [any PersistentModel.Type] {
        [OldActionLabelItem.self] // 最初のスキーマモデル
    }
}

// 新しいバージョン (V1) を定義
struct ActionLabelSchemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] {
        [ActionLabelCategory.self, ActionLabelItem.self]
    }
}

enum ActionLabelMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [ActionLabelSchemaV0.self, ActionLabelSchemaV1.self]
    }
    
    static var stages: [MigrationStage] {
        [
            migrateToV1
        ]
    }
    
    static let migrateToV1 = MigrationStage.custom(
        fromVersion: ActionLabelSchemaV0.self,
        toVersion: ActionLabelSchemaV1.self,
        willMigrate: nil
    ) { context in
        // "Default" カテゴリを作成
        let defaultCategory = ActionLabelCategory(categoryName: "Default")
        context.insert(defaultCategory)
        
        do {
            // 古い ActionLabelItem を取得
            let oldLabels = try context.fetch(FetchDescriptor<OldActionLabelItem>())
            
            oldLabels.forEach { oldLabel in
                // 新しい ActionLabelItem を作成し、カテゴリを関連付け
                let actionLabelItem = ActionLabelItem(label: oldLabel.label, category: defaultCategory)
                context.insert(actionLabelItem)
            }
            
            // データを保存
            try context.save()
        } catch {
            // エラーハンドリング
            print("Error during migration: \(error)")
            throw error
        }
    }
}

