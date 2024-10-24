//
//  ActionPresetItem.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/11.
//

import Foundation
import SwiftData

@Model
final class ActionPresetItem{
    var id = UUID()
    var presetName: String
    var actions: [ActionLabelPresetItem]
    
    init(presetName: String, actions: [ActionLabelPresetItem]) {
        self.presetName = presetName
        self.actions = actions
    }
}
