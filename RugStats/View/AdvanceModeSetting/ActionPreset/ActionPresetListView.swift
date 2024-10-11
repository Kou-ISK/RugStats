//
//  ActionPresetListView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/11.
//

import SwiftUI

struct ActionPresetListView: View {
    @Binding var actionPresetList: [ActionPresetItem]
    
    var body: some View {
        NavigationStack{
            VStack{
                List($actionPresetList, id:\.id){$actionPreset in
                    NavigationLink(destination: {
                        ActionPresetView(actionPreset: $actionPreset)
                    }, label: {
                        Text(actionPreset.presetName)
                    })
                }
            }.toolbar(content: {
                ToolbarItem(placement: .bottomBar ,content: {
                    NavigationLink(destination: CreateActionPresetView(), label: {
                        Image(systemName: "square.and.pencil")
                    })})
            })
        }
    }
}

#Preview {
    ActionPresetListView(actionPresetList: .constant([ActionPresetItem(presetName: "プリセット1", actions: [ActionLabelPresetItem(actionName: "タックル", labelSet: [ActionLabelItem(label: "成功"), ActionLabelItem(label: "失敗")])])]))
}
