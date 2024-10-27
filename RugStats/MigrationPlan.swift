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
        [ActionLabelItem.self] // 最初のスキーマモデル
    }
}

enum ActionLabelMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [ActionLabelSchemaV0.self, ActionLabelSchemaV1.self]
    }

    // マイグレーションステージを定義
    static var stages: [MigrationStage] {
        [
            migrateToV1
        ]
    }

    static let migrateToV1 = MigrationStage.custom(
        fromVersion: ActionLabelSchemaV0.self,  // 初期バージョンからの移行を定義
        toVersion: ActionLabelSchemaV1.self,
        willMigrate: nil
    ) { context in
        // "Default" カテゴリを作成
        let defaultCategory = ActionLabelCategory(categoryName: "Default")
        context.insert(defaultCategory)

        // 既存の ActionLabelItem を取得
        let existingLabels = try? context.fetch(FetchDescriptor<ActionLabelItem>())
        
        existingLabels?.forEach { existingLabel in
            // 新しい ActionLabelItem を作成し、カテゴリを関連付け
            let actionLabelItem = ActionLabelItem(label: existingLabel.label, category: defaultCategory)
            context.insert(actionLabelItem)
        }
        
        try? context.save()
    }
}

// 新しいバージョン (V1) を定義
struct ActionLabelSchemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] {
        [ActionLabelCategory.self, ActionLabelItem.self]
    }
}
