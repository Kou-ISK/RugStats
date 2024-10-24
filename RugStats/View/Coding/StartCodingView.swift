//
//  StartCodingView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI

struct StartCodingView: View {
    @Environment(\.modelContext) private var modelContext
    
    var teamPresetList: [TeamItem]
    var actionPresetList: [ActionPresetItem]
    
    @State private var newGame: GameItem = GameItem(date: Date(), team1Name: "", team2Name: "")
    @State private var showCodingView = false
    
    @State private var isAdvanceModeAvailable: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("基本情報入力")
            Form {
                Section(header: Text("チーム名を入力")) {
                    List{
                        // TODO: ビューの調整
                        TeamPicker(newTeam: $newGame.team1, teamPresetList: teamPresetList)
                        TeamPicker(newTeam: $newGame.team2, teamPresetList: teamPresetList)
                    }
                }
                
                Section{
                    DatePicker("キックオフ日時", selection: $newGame.date).datePickerStyle(.automatic)
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
                    checkIsAdvancedModeAvailable() // アドバンスモードが有効に出来るか判定
                    showCodingView = true // フォームが有効な場合に遷移フラグを立てる
                }
            }) {
                Text("分析開始")
            }
            .fullScreenCover(isPresented: $showCodingView) {
                CodingView(game: $newGame, isAdvanceModeAvailable: $isAdvanceModeAvailable, actionPresetList: actionPresetList)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!isFormValid()) // フォームが有効でない場合は非活性にする
        }
    }
    
    // フォームの入力が全て有効かどうかを判定する関数
    private func isFormValid() -> Bool {
        return !newGame.team1.teamName.isEmpty && !newGame.team2.teamName.isEmpty && !newGame.fieldName.isEmpty && !newGame.basicInfo.isEmpty
    }
    
    private func createNewGame() {
        modelContext.insert(newGame)
        do {
            try modelContext.save()
        } catch {
            print("Error saving game: \(error.localizedDescription)")
        }
    }
    
    private func checkIsAdvancedModeAvailable(){
        // アドバンスモードが有効にできるかを判定
        // playersもしくはアクションボタンプリセットが存在する場合
        if(!newGame.team1.players.isEmpty || !newGame.team2.players.isEmpty || !actionPresetList.isEmpty){
            isAdvanceModeAvailable = true
        }
    }
}

#Preview {
    StartCodingView(teamPresetList: [TeamItem(name: "チーム")], actionPresetList: [ActionPresetItem(presetName: "プリセット", actions: [ActionLabelPresetItem(actionName: "アクション", labelSet: [ActionLabelCategory(categoryName: "ラベル")])])])
}
