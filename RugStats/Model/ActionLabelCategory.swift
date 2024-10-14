//
//  ActionLabelCategory.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/14.
//

import Foundation
import SwiftData

@Model
final class ActionLabelCategory: Identifiable {
    var id = UUID()
    var categoryName: String
    var labels: [ActionLabelItem]
    
    init(categoryName: String){
        self.categoryName = categoryName
        self.labels = []
    }
}
