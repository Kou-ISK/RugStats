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
    @State private var showSuccessFailurePrompt = false // キック成否の選択肢を表示するかどうかのフラグ
    
    var zoneList: [String] {
        return [
            NSLocalizedString("Opp22m-GL", comment: "Zone: Opp22m-GL"),
            NSLocalizedString("Halfway-Opp22m", comment: "Zone: Halfway-Opp22m"),
            NSLocalizedString("22m-Halfway", comment: "Zone: 22m-Halfway"),
            NSLocalizedString("GL-22m", comment: "Zone: GL-22m")
        ]
    }
    
    var laneList: [String] {
        return [
            NSLocalizedString("Left", comment: "Lane: Left"),
            NSLocalizedString("Mid-Left", comment: "Lane: Mid-Left"),
            NSLocalizedString("Middle", comment: "Lane: Middle"),
            NSLocalizedString("Mid-Right", comment: "Lane: Mid-Right"),
            NSLocalizedString("Right", comment: "Lane: Right")
        ]
    }
    
    var body: some View {
        NavigationStack{
            Text("フィールドポジションを選択").font(.title)
            VStack {
                GeometryReader { geometry in
                    let fieldWidth = geometry.size.width
                    let fieldHeight = geometry.size.height
                    let imageAspectRatio: CGFloat = 70 / 100 // 縦100m、横70mのフィールド
                    
                    let adjustedWidth = min(fieldWidth, fieldHeight * imageAspectRatio)
                    let adjustedHeight = adjustedWidth / imageAspectRatio
                    
                    ZStack {
                        Image("FieldPosition")
                            .resizable()
                            .aspectRatio(imageAspectRatio, contentMode: .fit)
                            .frame(width: adjustedWidth, height: adjustedHeight)
                            .position(x: fieldWidth / 2, y: fieldHeight / 2)
                        
                        // ボタンの配置（隙間なく敷き詰める）
                        VStack(spacing:0) { // スペーシングを0にして隙間をなくす
                            ForEach(zoneList, id: \.self) { zone in
                                HStack(spacing:0) { // スペーシングを0にして隙間をなくす
                                    ForEach(laneList, id: \.self) { lane in
                                        Button(action: {
                                            // ラベルを付与する
                                            targetAction.actionLabels.append(zone)
                                            targetAction.actionLabels.append(lane)
                                            
                                            // コンバージョンG, PG, DGなら成功/失敗の選択肢を表示
                                            if targetAction.actionName == NSLocalizedString("コンバージョンG", comment: "Action: Conversion") ||
                                                targetAction.actionName == NSLocalizedString("PG", comment: "Action: PG") ||
                                                targetAction.actionName == NSLocalizedString("DG", comment: "Action: DG") {
                                                showSuccessFailurePrompt = true
                                            } else {
                                                saveLabel() // 通常の保存処理
                                                dismiss()
                                            }
                                        }) {
                                            Text("\(zone)\n\(lane)")
                                                .foregroundStyle(.black)
                                                .bold()
                                                .frame(maxWidth: adjustedWidth / CGFloat(laneList.count), maxHeight: adjustedHeight / CGFloat(zoneList.count))
                                        }.background(.gray).opacity(0.8).border(.white, width: 1)
                                    }
                                }
                            }
                        }
                    }
                }
                .alert(isPresented: $showSuccessFailurePrompt) {
                    Alert(
                        title: Text("ゴール成否"),
                        message: Text("キックの結果を選択してください"),
                        primaryButton: .default(Text("成功")) {
                            targetAction.actionLabels.append(NSLocalizedString("成功", comment: "キック: 成功"))
                            saveLabel()
                            dismiss()
                        },
                        secondaryButton: .destructive(Text("失敗")) {
                            targetAction.actionLabels.append(NSLocalizedString("失敗", comment: "キック: 失敗"))
                            saveLabel()
                            dismiss()
                        }
                    )
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
