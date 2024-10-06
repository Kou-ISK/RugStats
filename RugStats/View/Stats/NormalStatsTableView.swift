//
//  NormalStatsTableView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/03.
//

import SwiftUI

struct NormalStatsTableView: View {    
    @Binding var timeline: [TimelineItem]
    
    var body: some View {
        VStack(alignment: .leading) {
            // ヘッダー部分を作成
            ScrollView([.horizontal]) {
                HStack {
                    Text("チーム")
                        .bold()
                        .frame(width: 100, alignment: .leading)
                    Text("アクション")
                        .bold()
                        .frame(width: 100, alignment: .leading)
                    Text("ラベル")
                        .bold()
                        .frame(width: 100, alignment: .leading)
                    Text("ゲームクロック")
                        .bold()
                        .frame(width: 50, alignment: .leading)
                    Text("タイムスタンプ")
                        .bold()
                        .frame(width: 100, alignment: .leading)
                }.padding(.bottom, 5)
                
                Divider()
                ScrollView([.vertical]) {
                    VStack(alignment: .leading){
                        // データ部分を作成
                        ForEach(timeline) { item in
                            NormalStatsTableRow(item: item)
                            Divider()
                        }
                    }
                }
            }
        }.padding()
    }
}

#Preview {
    NormalStatsTableView(timeline: .constant([]))
}
