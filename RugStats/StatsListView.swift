//
//  StatsListView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI

struct StatsListView: View {
    @State var gameList: [GameItem]
    
    var body: some View {
        NavigationStack{
            Text("ゲーム一覧")
            List(gameList, id:\.id){game in
                NavigationLink(destination :{StatsView(game: game)}, label: {
                    VStack{
                        Text("\(game.team1Name) vs. \(game.team2Name)")
                        Text("@\(game.fieldName)")
                        Text("備考: \(game.basicInfo)")
                    }
                })
            }
        }
    }
}

#Preview {
    StatsListView(gameList: [GameItem(timestamp: Date(), team1Name: "チームA", team2Name: "チームB"), GameItem(timestamp: Date(), team1Name: "チームC", team2Name: "チームD")])
}
