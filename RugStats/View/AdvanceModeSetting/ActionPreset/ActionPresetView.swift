//
//  ActionPresetView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/11.
//

import SwiftUI

struct ActionPresetView: View {
    @Binding var actionPreset: ActionPresetItem
    
    var body: some View {
        TextField("プリセット名", text: $actionPreset.presetName)
        List($actionPreset.actions, id:\.id){$action in
            NavigationLink(destination: ActionPresetLabelView(action: $action), label: {
                TextField("アクション名", text: $action.actionName)
            })
        }
    }
}

#Preview {
    ActionPresetView(actionPreset: .constant(ActionPresetItem(presetName: "プリセット名", actions: [ActionLabelPresetItem(actionName: "アクション", labelSet: [ActionLabelItem(label: "ラベル")])])))
}
