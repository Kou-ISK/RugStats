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
    // TODO: categoryを追加するか検討
    
    init(label: String){
        self.label = label
    }
}
