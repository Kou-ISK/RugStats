//
//  ActionPresetLabelView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/11.
//

import SwiftUI

struct ActionPresetLabelView: View {
    @Binding var action: ActionLabelPresetItem
    
    var body: some View {
        List($action.labelSet, id:\.id){$label in
            TextField("ラベル", text: $label.label)
        }
    }
}

#Preview {
    ActionPresetLabelView(action: .constant(ActionLabelPresetItem(actionName: "アクション", labelSet: [ActionLabelItem(label: "ラベル")])))
}