//
//  Arrow.swift
//  RugStats
//
//  Created by 井坂航 on 2024/11/05.
//

import SwiftUI

struct Arrow: View {
    var action: TimelineItem
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    
    var body: some View {
        if let startX = action.startXcoord, let startY = action.startYcoord,
           let endX = action.endXcoord, let endY = action.endYcoord {
            
            // 始点と終点の座標を計算
            let startPosition = calculatePosition(xCoord: startX, yCoord: 100 - startY, imageWidth: imageWidth, imageHeight: imageHeight)
            let endPosition = calculatePosition(xCoord: endX, yCoord: 100 - endY, imageWidth: imageWidth, imageHeight: imageHeight)
            
            // 矢印の描画
            Path { path in
                path.move(to: startPosition)
                path.addLine(to: endPosition)
                
                // 矢じりの計算
                let arrowHeadLength: CGFloat = 10.0
                let angle: CGFloat = .pi / 6  // 矢じりの角度
                let dx = endPosition.x - startPosition.x
                let dy = endPosition.y - startPosition.y
                let length = sqrt(dx * dx + dy * dy)
                
                // 矢じりの左側
                let leftArrowPoint = CGPoint(
                    x: endPosition.x - arrowHeadLength * (dx * cos(angle) - dy * sin(angle)) / length,
                    y: endPosition.y - arrowHeadLength * (dx * sin(angle) + dy * cos(angle)) / length
                )
                
                // 矢じりの右側
                let rightArrowPoint = CGPoint(
                    x: endPosition.x - arrowHeadLength * (dx * cos(-angle) - dy * sin(-angle)) / length,
                    y: endPosition.y - arrowHeadLength * (dx * sin(-angle) + dy * cos(-angle)) / length
                )
                
                // 矢じりを追加
                path.move(to: endPosition)
                path.addLine(to: leftArrowPoint)
                path.move(to: endPosition)
                path.addLine(to: rightArrowPoint)
            }
            .stroke(Color.red, lineWidth: 3)
        } else if let startX = action.startXcoord, let startY = action.startYcoord {
            // 終点の座標がない場合は点を表示
            let startCirclePosition = calculatePosition(xCoord: startX, yCoord: 100 - startY, imageWidth: imageWidth, imageHeight: imageHeight)
            Circle()
                .fill(Color.red)
                .frame(width: 20, height: 20) // 表示する点の大きさ
                .position(startCirclePosition) // タップされた場所に合わせて座標を調整
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
    Arrow(action: TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), endGameClock: TimeInterval(200), actorName: "チーム1", actionName: "タックル", startXcoord: 10, startYcoord: 20, endXcoord: 50, endYcoord: 70), imageWidth: 300, imageHeight: 400)
}
