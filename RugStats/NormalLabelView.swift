//
//  NormalLabelView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/03.
//

import SwiftUI

struct NormalLabelView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Binding var targetAction: TimelineItem
    @State var isPushed: Bool
    var zoneList = ["敵陣22m-トライライン","敵陣10m-敵陣22m", "自陣10m-敵陣10m", "自陣22m-自陣10m", "自陣トライライン-自陣22m"]
    var laneList = ["左", "中央", "右"]
    var body: some View {
        VStack{
            ForEach(zoneList, id:\.self){zone in
                HStack{
                    ForEach(laneList, id:\.self){lane in
                        Button("\(zone)\n\(lane)"){
                            print("\(zone) \(lane)")
                            targetAction.actionLabels.append(zone)
                            targetAction.actionLabels.append(lane)
                            
                            // TODO modelContextに保存されるように修正
                            do{
                                try modelContext.save()
                            }catch{
                                print("Error: \(error.localizedDescription)")
                            }
                            isPushed.toggle()
                            dismiss()
                        }.buttonStyle(.borderedProminent)
                    }
                }
            }
        }
    }
}

#Preview {
    NormalLabelView(targetAction: .constant(TimelineItem(timestamp: Date(), gameTime: TimeInterval(10), actorName: "チーム1", actionName: "トライ")), isPushed: false)
}
