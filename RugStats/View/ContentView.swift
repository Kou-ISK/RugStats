//
//  ContentView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/02.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var gameList: [GameItem]
    
    var body: some View {
        NavigationStack{
            List{
                NavigationLink(destination: StartCodingView(), label: {Text("分析する")})
                NavigationLink(destination: StatsListView(gameList: gameList), label: {Text("ゲーム一覧")})
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GameItem.self, inMemory: true)
}
