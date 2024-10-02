//
//  CodingView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI

struct CodingView: View {
    var game: GameItem
    var body: some View {
        // ノーマルモードとアドバンスモードを切り替えられるようにする
        // ノーマルモードはスコアシート用のもののみ
        // アドバンスモードはグラウンド、各種ボタン、各種ラベル
        // エンハンスでは選手名を登録して簡単にスタッツを取れるようにするか？
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CodingView(game: GameItem(timestamp: Date(), team1Name: "チーム1", team2Name: "チーム2"))
}
