//
//  AdvancedFieldPositionView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/16.
//

import SwiftUI

struct AdvancedFieldPositionView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Binding var action: TimelineItem
    
    @State private var tapLocation: CGPoint = .zero // タップされた場所の座標
    
    var isStartLocation: Bool
    
    var body: some View {
        NavigationStack {
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
                        
                        VStack{
                            ZStack{
                                Image(systemName: "arrowshape.up.fill").resizable().frame(width: 300, height: 500).foregroundStyle(.gray).opacity(0.2)
                                Text("\(action.actorName)の攻撃方向").font(.title).bold().offset(y: 190)
                            }
                        }
                        
                        // TODO: 正しく表示されるように修正
                        // 始点の座標データが存在する場合に表示する
                        if let startX = action.startXcoord, let startY = action.startYcoord {
                            let startCirclePosition = calculatePosition(xCoord: startX, yCoord: startY, imageWidth: imageWidth, imageHeight: imageHeight)
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 30, height: 30) // 表示する点の大きさ
                                .position(startCirclePosition) // タップされた場所に合わせて座標を調整
                        }
                        
                        // タップされた位置に点を表示
                        if tapLocation != .zero {
                            let tapCirclePosition = calculatePosition(xCoord: Int(tapLocation.x), yCoord: Int(tapLocation.y), imageWidth: imageWidth, imageHeight: imageHeight)
                            Circle()
                                .fill(Color.red)
                                .frame(width: 30, height: 30) // 表示する点の大きさ
                                .position(tapCirclePosition) // タップされた場所に合わせて座標を調整
                        }
                        
                        // エリア背景（透明なタップ可能エリア）
                        Color.clear
                            .contentShape(Rectangle()) // タップ可能エリアを指定
                            .onTapGesture { location in
                                tapLocation = convertTapLocation(location: location, imageWidth: imageWidth, imageHeight: imageHeight)
                            }
                            .frame(width: totalWidth, height: imageHeight) // タップエリアを元のサイズに維持
                    }
                    .padding(.vertical, verticalPadding) // 上下に余白を追加
                }
                .aspectRatio(70/100, contentMode: .fit) // 全体のアスペクト比を保つ
            }
            .navigationTitle("座標を入力")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("完了") {
                        if isStartLocation {
                            action.startXcoord = Int(tapLocation.x)
                            // TODO: 画像下部をタップするとY座標が負になる問題に対処
                            action.startYcoord = Int(tapLocation.y)
                        } else {
                            action.endXcoord = Int(tapLocation.x)
                            action.endYcoord = Int(tapLocation.y)
                        }
                        // SwiftDataに保存
                        do {
                            try modelContext.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                        dismiss()
                    }
                }
            }
        }
    }
    
    // 座標計算を分割して処理
    private func calculatePosition(xCoord: Int, yCoord: Int, imageWidth: CGFloat, imageHeight: CGFloat) -> CGPoint {
        let x = CGFloat(xCoord) * (imageWidth / 80) + 5 * (imageWidth / 80)
        let y = (110 - CGFloat(yCoord)) * (imageHeight / 120)
        return CGPoint(x: x, y: y)
    }
    
    // タップされた位置を正規化して座標に変換
    private func convertTapLocation(location: CGPoint, imageWidth: CGFloat, imageHeight: CGFloat) -> CGPoint {
        let normalizedX = (location.x / imageWidth) * 80 - 5
        let normalizedY = (imageHeight - location.y) / imageHeight * 120 - 10
        return CGPoint(x: normalizedX, y: normalizedY)
    }
}

#Preview {
    AdvancedFieldPositionView(action: .constant(TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(100), actorName: "チーム1", actionName: "アクション")), isStartLocation: true)
}
