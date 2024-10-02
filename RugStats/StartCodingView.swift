//
//  StartCodingView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI

struct StartCodingView: View {
    @State private var team1Name: String = ""
    @State private var team2Name: String = ""
    @State private var fieldName: String = ""
    @State private var basicInfo: String = ""
    
    var body: some View {
        NavigationStack{
            Text("基本情報入力")
            Form{
                Text("チーム名を入力")
                HStack{
                    TextField("例) XX大学", text: $team1Name)
                    Spacer()
                    TextField("例) YY大学", text: $team2Name)
                }
                
                Text("グラウンド名を入力")
                TextField("例) XXスタジアム", text: $fieldName)
                
                Text("備考を入力")
                TextField("例) 公式戦", text: $basicInfo)
                
            }
            NavigationLink("分析開始"){
                let newGame = GameItem(timestamp: Date(), team1Name: team1Name, team2Name: team2Name, fieldName: fieldName, basicInfo: basicInfo)
                CodingView(game: newGame)
            }.buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    StartCodingView()
}
