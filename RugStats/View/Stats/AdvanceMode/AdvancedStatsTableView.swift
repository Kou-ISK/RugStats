//
//  AdvancedStatsTableView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/17.
//

import SwiftUI

struct AdvancedStatsTableView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var timeline: [TimelineItem]
    @State private var isEditMode: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            // ヘッダー部分を作成
            ScrollView([.horizontal]) {
                HStack {
                    Text("チーム")
                        .bold()
                        .frame(width: 100, alignment: .center)
                    Text("アクション")
                        .bold()
                        .frame(width: 100, alignment: .center)
                    Text("ラベル")
                        .bold()
                        .frame(minWidth: 150, alignment: .center)
                    Text("座標(開始)")
                        .bold()
                        .frame(minWidth: 100, alignment: .center)
                    Text("座標(終了)")
                        .bold()
                        .frame(minWidth: 100, alignment: .center)
                    Text("ゲームクロック")
                        .bold()
                        .frame(width: 100, alignment: .leading)
                    Text("タイムスタンプ")
                        .bold()
                        .frame(width: 100, alignment: .leading)
                    Button(isEditMode ? "完了" : "編集"){
                        isEditMode.toggle()
                    }.buttonStyle(.borderless)
                }.padding(.bottom, 5)
                
                Divider()
                ScrollView([.vertical]) {
                    VStack(alignment: .leading){
                        // データ部分を作成
                        ForEach($timeline.sorted(by: {$0.wrappedValue.startTimestamp < $1.wrappedValue.startTimestamp}), id: \.id) { $item in
                            HStack{
                                if isEditMode {
                                    Button(action: {
                                        if let index = timeline.firstIndex(where: { $0.id == item.id }) {
                                            timeline.remove(at: index) // タイムラインから削除
                                            do {
                                                try modelContext.save() // データベースを保存
                                            } catch {
                                                print(error.localizedDescription)
                                            }
                                        }
                                    }, label: {
                                        Image(systemName: "minus.circle.fill")
                                    }).buttonStyle(.borderless).tint(.red)
                                }
                                AdvancedStatsTableRow(item: $item)
                            }
                            Divider()
                        }
                    }
                }
            }
        }.padding()
    }
}

#Preview {
    AdvancedStatsTableView(timeline: .constant([TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(10), actorName: "チーム1", actionName: "トライ"), TimelineItem(startTimestamp: Date(), startGameClock: TimeInterval(10), actorName: "チーム2", actionName: "トライ")]))
}
