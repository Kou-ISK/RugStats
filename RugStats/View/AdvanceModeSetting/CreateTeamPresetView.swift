//
//  CreateTeamPresetView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/09.
//

import SwiftUI

struct CreateTeamPresetView: View {
    // 一時的にチームカラーを保持する変数
    @State private var currentColor: CGColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
    @State private var newTeam: TeamItem = TeamItem(name: "")
    
    var body: some View {
        VStack{
            TextField("チーム名", text: $newTeam.name)
            ColorPicker("チームカラー選択", selection: $currentColor, supportsOpacity: true)
            // TODO 選手追加用コンポーネント作成
            
            Button("チーム作成"){
                // TODO CGColorからRGBの値を取得してColorItemに設定する
                let newTeamColor = ColorItem(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>)
                newTeam.teamColor = newTeamColor
                
                // TODO SwiftDataに保存
                // TODO dismiss
            }
        }
    }
}

#Preview {
    CreateTeamPresetView()
}
