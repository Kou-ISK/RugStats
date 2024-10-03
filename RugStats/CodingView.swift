//
//  CodingView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI

struct CodingView: View {
    @State var game: GameItem
    @State var gameTime: TimeInterval = TimeInterval(0)
    @State private var isAdvanceMode: Bool = false
    
    var body: some View {
        // ノーマルモードとアドバンスモードを切り替えられるようにする
        // ノーマルモードはスコアシート用のもののみ
        
        // エンハンスでは選手名を登録して簡単にスタッツを取れるようにするか？
        VStack{
            if(isAdvanceMode){
                // アドバンスモードはグラウンド、各種ボタン、各種ラベル
            }else{
                NormalCodingView(gameInfo: game, gameTime: gameTime)
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
    CodingView(game: GameItem(timestamp: Date(), team1Name: "チーム1", team2Name: "チーム2", fieldName: "XXスタジアム", basicInfo: "公式戦"))
}
