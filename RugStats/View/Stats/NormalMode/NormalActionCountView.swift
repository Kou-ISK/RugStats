//
//  NormalActionCountView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/07.
//

import SwiftUI

struct NormalActionCountView: View {
    @Binding var game: GameItem
    
    var body: some View {
            let actions = game.timeline
            return VStack{
                ForEach(actionList, id:\.self){action in
                    HStack{
                        Text(String(actions.count(where: {$0.actionName == action && $0.actorName == game.team1Name})))
                        Text(action)
                        Text(String(actions.count(where: {$0.actionName == action && $0.actorName == game.team2Name})))
                    }
                }
            }
    }
}

#Preview {
    NormalActionCountView(game: .constant(GameItem(date: Date(), team1Name: "チーム1", team2Name: "チーム2")))
}
