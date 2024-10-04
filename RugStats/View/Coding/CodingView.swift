//
//  CodingView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI

struct CodingView: View {
    @Binding var game: GameItem
    
    @State var gameClock: TimeInterval = TimeInterval(0)
    @State private var isAdvanceMode: Bool = false
    
    @State private var timer: Timer? = nil // ストップウォッチ用のタイマー
    @State private var isRunning: Bool = false // ストップウォッチの状態
    
    // TODO 戻るボタン押下時にalertを表示する
    var body: some View {
        // ノーマルモードとアドバンスモードを切り替えられるようにする
        // ノーマルモードはスコアシート用のもののみ
        
        // エンハンスでは選手名を登録して簡単にスタッツを取れるようにするか？
        VStack{
            GameClockView(gameClock: $gameClock, timer: $timer, isRunning: $isRunning)
            
            
            if(isAdvanceMode){
                // アドバンスモードはグラウンド、各種ボタン、各種ラベル
            }else{
                NormalCodingView(gameInfo: $game, gameClock: $gameClock)
            }
        }.toolbar{
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(isAdvanceMode ? "ノーマル": "アドバンス"){
                    isAdvanceMode.toggle()
                }
            })
        }
    }
}

#Preview {
    CodingView(game: .constant(GameItem(timestamp: Date(), team1Name: "チーム1", team2Name: "チーム2", fieldName: "XXスタジアム", basicInfo: "公式戦")))
}
