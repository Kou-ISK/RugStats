//
//  TeamPresetView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/11.
//

import SwiftUI

struct TeamPresetView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var team: TeamItem
    @State private var currentColor: Color = Color(.white)
    
    var body: some View {
        VStack{
            HStack{
                TextField("チーム名", text: $team.name)
                ColorPicker("チームカラー", selection: $currentColor, supportsOpacity: true)
            }
            List($team.players, id:\.id){$player in
                TextField("選手名", text: $player.name)
            }
        }.onAppear{
            setCurrentColor()
        }
        .onDisappear{
            // 画面遷移時に保存
            saveCurrentColor()
            do {
                try modelContext.save()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    private func setCurrentColor(){
        currentColor = Color(cgColor: CGColor(red: team.teamColor?.red ?? 0, green: team.teamColor?.green ?? 0, blue: team.teamColor?.blue ?? 0, alpha: team.teamColor?.alpha ?? 0))
    }
    
    private func saveCurrentColor(){
        // RGB 成分を取得
        if let rgb = currentColor.toRGB(){
            // ColorItem を作成
            let newTeamColor = ColorItem(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha:rgb.alpha)
            team.teamColor = newTeamColor
        }
    }
}

#Preview {
    TeamPresetView(team: .constant(TeamItem(name: "チーム")))
}
