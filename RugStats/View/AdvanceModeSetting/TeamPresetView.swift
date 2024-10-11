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
    @State private var currentColor: CGColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
    
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
            do {
                try modelContext.save()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    private func setCurrentColor(){
        currentColor = CGColor(red: team.teamColor?.red ?? 0, green: team.teamColor?.green ?? 0, blue: team.teamColor?.blue ?? 0, alpha: team.teamColor?.alpha ?? 0)
    }
}

#Preview {
    TeamPresetView(team: .constant(TeamItem(name: "チーム")))
}
