//
//  StartCodingView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI

struct StartCodingView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var team1Name: String = ""
    @State private var team2Name: String = ""
    @State private var fieldName: String = ""
    @State private var basicInfo: String = ""
    @State private var newGame: GameItem? = nil
    @State private var showCodingView = false // CodingViewへの遷移制御用

    var body: some View {
        NavigationStack {
            VStack {
                Text("基本情報入力")
                    .font(.title)
                
                Form {
                    Section(header: Text("チーム名を入力")) {
                        HStack {
                            TextField("例) XX大学", text: $team1Name)
                            Spacer()
                            TextField("例) YY大学", text: $team2Name)
                        }
                    }
                    
                    Section(header: Text("グラウンド名を入力")) {
                        TextField("例) XXスタジアム", text: $fieldName)
                    }
                    
                    Section(header: Text("備考を入力")) {
                        TextField("例) 公式戦", text: $basicInfo)
                    }
                }
                
                Button(action: {
                    createNewGame()
                    if isFormValid() {
                        showCodingView = true // フォームが有効な場合に遷移フラグを立てる
                    }
                }) {
                    Text("分析開始")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(!isFormValid()) // フォームが有効でない場合は非活性にする
                
                // TODO 推奨される画面遷移方法に変更する
                NavigationLink(destination: CodingView(game: newGame ?? GameItem(timestamp: Date(), team1Name: "デフォルト1", team2Name: "デフォルト2", fieldName: "デフォルトグラウンド", basicInfo: "デフォルト備考"), gameTime: 0), isActive: $showCodingView) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
    
    // フォームの入力が全て有効かどうかを判定する関数
    private func isFormValid() -> Bool {
        return !team1Name.isEmpty && !team2Name.isEmpty && !fieldName.isEmpty && !basicInfo.isEmpty
    }
    
    private func createNewGame() {
        let game = GameItem(
            timestamp: Date(),
            team1Name: team1Name,
            team2Name: team2Name,
            fieldName: fieldName,
            basicInfo: basicInfo
        )
        
        modelContext.insert(game)
        do {
            try modelContext.save()
            newGame = game
        } catch {
            print("Error saving game: \(error.localizedDescription)")
        }
    }
}

#Preview {
    StartCodingView()
}
