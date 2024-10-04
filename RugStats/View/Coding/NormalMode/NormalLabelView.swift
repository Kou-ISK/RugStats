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
    
    var zoneList = ["敵陣22mイン", "敵陣22mアウト", "自陣22mアウト", "自陣22mイン"]
    var laneList = ["左", "中央", "右"]
    
    var body: some View {
        VStack{
            Text("フィールドポジションを選択").font(.title)
            // TODO Viewがシンプルになるようにリファクタする
            GeometryReader { geometry in
                let fieldWidth = geometry.size.width
                let fieldHeight = geometry.size.height
                let imageAspectRatio: CGFloat = 70 / 100 // 縦100m、横70mのフィールド
                
                // 画像が画面にフィットするように縦横比を維持してサイズ調整
                let adjustedWidth = min(fieldWidth, fieldHeight * imageAspectRatio)
                let adjustedHeight = adjustedWidth / imageAspectRatio
                
                ZStack {
                    // グラウンド画像をアスペクト比を維持して画面にフィットさせる
                    Image("FieldPosition")
                        .resizable()
                        .aspectRatio(imageAspectRatio, contentMode: .fit)
                        .frame(width: adjustedWidth, height: adjustedHeight)
                        .position(x: fieldWidth / 2, y: fieldHeight / 2) // 画像を中央に配置
                    
                    // ボタンの配置（隙間なく敷き詰める）
                    VStack(spacing:0) { // スペーシングを0にして隙間をなくす
                        ForEach(zoneList, id: \.self) { zone in
                            HStack(spacing:0) { // スペーシングを0にして隙間をなくす
                                ForEach(laneList, id: \.self) { lane in
                                    Button(action: {
                                        print("\(zone) \(lane)")
                                        // ラベルを付与する
                                        targetAction.actionLabels.append(zone)
                                        targetAction.actionLabels.append(lane)
                                        
                                        // modelContextに保存
                                        saveLabel()
                                        
                                        // モーダルを閉じる
                                        dismiss()}
                                    ){
                                        Text("\(zone)\n\(lane)")
                                            .foregroundStyle(.black).font(.title2)
                                            .bold()
                                            .frame(maxWidth: adjustedWidth / CGFloat(laneList.count), maxHeight: adjustedHeight / CGFloat(zoneList.count))
                                    }.background(.gray).opacity(0.8).border(.white, width: 1)
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func saveLabel() {
        modelContext.insert(targetAction)
        do {
            try modelContext.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    NormalLabelView(targetAction: .constant(TimelineItem(timestamp: Date(), gameClock: TimeInterval(10), actorName: "チーム1", actionName: "トライ")))
}
