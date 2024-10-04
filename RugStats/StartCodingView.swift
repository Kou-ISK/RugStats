//
//  StartCodingView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI

struct StartCodingView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var newGame: GameItem = GameItem(timestamp: Date(), team1Name: "", team2Name: "")
    @State private var showCodingView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("基本情報入力")
                    .font(.title)
                
                Form {
                    Section(header: Text("チーム名を入力")) {
                        HStack {
                            TextField("例) XX大学", text: $newGame.team1Name)
                            Spacer()
                            TextField("例) YY大学", text: $newGame.team2Name)
                        }
                    }
                    
                    Section(header: Text("グラウンド名を入力")) {
                        TextField("例) XXスタジアム", text: $newGame.fieldName)
                    }
                    
                    Section(header: Text("備考を入力")) {
                        TextField("例) 公式戦", text: $newGame.basicInfo)
                    }
                }
                
                Button(action: {
                    if isFormValid() { // フォームが有効な場合に処理を行う
                        createNewGame()
                        showCodingView = true // フォームが有効な場合に遷移フラグを立てる
                    }
                }) {
                    Text("分析開始")
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isFormValid()) // フォームが有効でない場合は非活性にする
                
                // NavigationLinkの修正
                NavigationLink(destination: CodingView(game: $newGame), isActive: $showCodingView) {
                    EmptyView() // NavigationLinkはボタンを表示しないため、EmptyViewを使用
                }
            }
            .padding()
        }
    }
    
    // フォームの入力が全て有効かどうかを判定する関数
    private func isFormValid() -> Bool {
        return !newGame.team1Name.isEmpty && !newGame.team2Name.isEmpty && !newGame.fieldName.isEmpty && !newGame.basicInfo.isEmpty
    }
    
    private func createNewGame() {
        modelContext.insert(newGame)
        do {
            try modelContext.save()
        } catch {
            print("Error saving game: \(error.localizedDescription)")
        }
    }
}

#Preview {
    StartCodingView()
}
