//
//  AdvancedLabelView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/15.
//

import SwiftUI

struct AdvancedLabelView: View {
    var labelSet: [ActionLabelCategory]
    
    var body: some View {
        ForEach(labelSet, id: \.id){category in
            Text(category.categoryName)
            ForEach(category.labels, id: \.id){label in
                Button(action: {},label: {Text(label.label)})}
        }
    }
}

#Preview {
    AdvancedLabelView(labelSet: [ActionLabelCategory(categoryName: "カテゴリ")])
}
