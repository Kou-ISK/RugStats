//
//  AdvancedStatsFieldPositionView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/11/03.
//

import SwiftUI

struct AdvancedStatsFieldPositionView: View {
    @Binding var game: GameItem
    // 選択されたアクション名
    @State private var selectedAction: String = ""
    @State private var selectedActor: String = ""
    
    var selectedTimeline: [TimelineItem]{
        return game.timeline.filter({$0.actorName == selectedActor && $0.actionName == selectedAction})
    }
    
    var teamList: [String]{
        [game.team1.teamName, game.team2.teamName]
    }
    
    var body: some View {
        // Pickerでアクションを選択
        ActionPicker(selectedAction: $selectedAction, timeline: game.timeline)
        // Pickerでアクターを選択
        ActorPicker(selectedActor: $selectedActor, timeline: game.timeline, teamList: teamList)
        VStack {
            GeometryReader { geometry in
                let totalWidth = geometry.size.width // 全体の幅
                let totalHeight = geometry.size.height // 全体の高さ
                let imageWidth = totalWidth - 10 // 左右の余白を引いた画像の幅（元のサイズを保持）
                let imageHeight = imageWidth * (100 / 70) // 70:100の比率の高さ
                let padding: CGFloat = 10 // 左右の余白を広くするための定数
                let verticalPadding = (totalHeight - imageHeight) / 2 // 上下に均等に余白
                
                ZStack {
                    // 画像の表示
                    Image("FieldPosition") // 使用する画像名を指定
                        .resizable()
                        .aspectRatio(70/100, contentMode: .fit)
                        .frame(width: imageWidth - padding * 2, height: imageHeight) // 画像の幅を調整
                        .padding(.horizontal, padding) // 左右に余白を追加
                        .opacity(0.4)
                    
                    VStack {
                        ZStack {
                            Image(systemName: "arrowshape.up.fill").resizable().frame(width: 300, height: 500).foregroundStyle(.gray).opacity(0.2)
                        }
                    }
                    
                    ForEach(selectedTimeline, id:\.id){action in
                        // 始点の座標データが存在する場合に表示する
                        Arrow(action: action, imageWidth: imageWidth, imageHeight: imageHeight)
                    }
                }
                .padding(.vertical, verticalPadding) // 上下に余白を追加
            }
            .aspectRatio(70/100, contentMode: .fit) // 全体のアスペクト比を保つ
        }
    }
    
    // 座標計算を分割して処理
    private func calculatePosition(xCoord: Int, yCoord: Int, imageWidth: CGFloat, imageHeight: CGFloat) -> CGPoint {
        let x = CGFloat(xCoord) * (imageWidth / 80) + 5 * (imageWidth / 80)
        let y = (CGFloat(yCoord) + 10) * (imageHeight / 120)
        return CGPoint(x: x, y: y)
    }
}

#Preview {
    AdvancedStatsFieldPositionView(game: .constant(GameItem(date: Date(), team1Name: "チーム1", team2Name: "チーム2")))
}
