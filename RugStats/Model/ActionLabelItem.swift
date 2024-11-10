//
//  ActionLabelItem.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/07.
//

import Foundation
import SwiftData

@Model
final class ActionLabelItem: Identifiable {
    var id = UUID()
    var label: String
    
    @Relationship
    var category: ActionLabelCategory // カテゴリへの参照を追加
    
    init(label: String, category: ActionLabelCategory) {
        self.label = label
        self.category = category
    }
}

@Model
final class OldActionLabelItem: Identifiable {
    var id = UUID()
    var label: String

    init(label: String){
        self.label = label
    }
}
