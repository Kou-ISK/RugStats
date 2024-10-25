//
//  CodingView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI

struct CodingView: View {
    @Environment(\.dismiss) private var dismiss // 画面を閉じるための環境変数
    
    @Binding var game: GameItem
    @Binding var isAdvancedModeAvailable: Bool
    
    var actionPresetList: [ActionPresetItem]
    @State var gameClock: TimeInterval = TimeInterval(0)
    @State private var showBackAlert: Bool = false
    @State private var isAdvancedMode: Bool = false
    
    @State private var timer: Timer? = nil // ストップウォッチ用のタイマー
    @State private var isRunning: Bool = false // ストップウォッチの状態
    
    var body: some View {
        // ノーマルモードとアドバンスモードを切り替えられるようにする
        // ノーマルモードはスコアシート用のもののみ
        
        // エンハンスでは選手名を登録して簡単にスタッツを取れるようにするか？
        NavigationStack{
            VStack{
                GameClockView(gameClock: $gameClock, timer: $timer, isRunning: $isRunning)
                ScoreView(game: game)
                
                if(isAdvancedMode){
                    AdvancedCodingView(gameInfo: $game, gameClock: $gameClock, actionPresetList: actionPresetList)
                }else{
                    NormalCodingView(gameInfo: $game, gameClock: $gameClock)
                }
            }.toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showBackAlert = true // アラートを表示
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("戻る")
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(isAdvancedMode ? "ノーマル": "アドバンス"){
                        isAdvancedMode.toggle()
                    }.disabled(!isAdvancedModeAvailable)
                })
            }
            .alert(isPresented: $showBackAlert) {
                Alert(
                    title: Text("確認"),
                    message: Text("コーディングを終了しますか？"),
                    primaryButton: .destructive(Text("終了")) {
                        dismiss() // 元の画面に戻る
                    },
                    secondaryButton: .cancel(Text("キャンセル"))
                )
            }
        }
    }
}

#Preview {
    CodingView(game: .constant(GameItem(date: Date(), team1Name: "チーム1", team2Name: "チーム2", fieldName: "XXスタジアム", basicInfo: "公式戦")), isAdvancedModeAvailable: .constant(true), actionPresetList: [ActionPresetItem(presetName: "プリセット", actions: [ActionLabelPresetItem(actionName: "アクション", labelSet: [ActionLabelCategory(categoryName: "ラベル")])])])
}
