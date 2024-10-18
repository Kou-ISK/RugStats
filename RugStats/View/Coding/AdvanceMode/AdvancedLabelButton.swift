//
//  AdvancedLabelButton.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/18.
//

import SwiftUI

struct AdvancedLabelButton: View {
    @Binding var action: TimelineItem
    
    @State private var isPushed: Bool = false
    
    var label: ActionLabelItem
    
    var body: some View {
        Button(action: {
            isPushed.toggle()  // isPushedをトグルで更新
            
            // ボタンを押されたらactionLabelsに追加
            if(isPushed){
                action.actionLabels.append(label)
            }else{
                if let index = action.actionLabels.firstIndex(where: {$0.id == label.id}){
                    action.actionLabels.remove(at: index)
                }
            }
        }, label: {
            Text(label.label)
        }).buttonStyle(.borderedProminent)
            .tint(isPushed ? .green : .gray)
            .onAppear{
                isPushed = action.actionLabels.contains(label)
            }
    }
}

#Preview {
    AdvancedLabelButton(action: .constant(TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), actorName: "チーム1", actionName: "タックル")),  label: ActionLabelItem(label: "ラベル"))
}
