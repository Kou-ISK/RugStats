//
//  MigrationPlan.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/26.
//

import Foundation
import SwiftData

// スキーマバージョンの初期状態を定義
struct ActionLabelSchemaV0: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(0, 0, 0)
    static var models: [any PersistentModel.Type] {
        [ActionLabelItem.self] // 旧スキーマでのモデル
    }
}

enum ActionLabelMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [ActionLabelSchemaV1.self]  // 新しいスキーマを指定
    }

    // マイグレーションのステージを定義
    static var stages: [MigrationStage] {
        [
            migrateToV1
        ]
    }

    static let migrateToV1 = MigrationStage.custom(
        fromVersion: ActionLabelSchemaV0.self,  // 以前のバージョンを指定
        toVersion: ActionLabelSchemaV1.self,
        willMigrate: nil
    ) { context in
        // 新しいカテゴリを作成（例: "Default" カテゴリ）
        let defaultCategory = ActionLabelCategory(categoryName: "Default")
        context.insert(defaultCategory)

        // 既存の ActionLabelItem を取得
        let existingLabels = try? context.fetch(FetchDescriptor<ActionLabelItem>())
        
        existingLabels?.forEach { existingLabel in
            // それぞれのラベルに対して新しい ActionLabelItem を作成し、デフォルトカテゴリに関連付ける
            let actionLabelItem = ActionLabelItem(label: existingLabel.label, category: defaultCategory)
            context.insert(actionLabelItem)
        }
        
        try? context.save()
    }
}

struct ActionLabelSchemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] {
        [ActionLabelCategory.self, ActionLabelItem.self]
    }
}
