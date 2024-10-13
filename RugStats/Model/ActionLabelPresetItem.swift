//
//  ActionLabelPresetItem.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/11.
//

import Foundation
import SwiftData

@Model
final class ActionLabelPresetItem{
    var id = UUID()
    var actionName: String
    var labelSet: [ActionLabelItem]
    
    init(actionName: String, labelSet: [ActionLabelItem]) {
        self.actionName = actionName
        self.labelSet = labelSet
    }
}
